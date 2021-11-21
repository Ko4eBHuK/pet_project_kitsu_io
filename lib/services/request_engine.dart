import 'dart:io';
import 'dart:convert' as convert;

import 'package:http/http.dart' as HTTP;

import '/user_engine/User.dart';
import '/anime_engine/AnimeItem.dart';

Future<User> searchUserByName(String userName) async {
  var url = Uri.parse('https://kitsu.io/api/edge/users?filter[name]=$userName');

  User gettedUser = User(id: 0);

  try {
    final response = await HTTP.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      if (jsonResponse['meta']['count'] >= 1) {
        gettedUser = User.fromJson(jsonResponse);

        var waifuResponse =
            await HTTP.get(Uri.parse('https://kitsu.io/api/edge/users/${gettedUser.id}/waifu'));
        var waifuJsonResponse = convert.jsonDecode(waifuResponse.body) as Map<String, dynamic>;
        gettedUser.waifuName = waifuJsonResponse['data'] != null
            ? waifuJsonResponse['data']['attributes']['canonicalName']
            : null;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return gettedUser;
  } on SocketException {
    gettedUser.id = -1;
    return gettedUser;
  }
}

Future<List<AnimeItem>> searchAnimeUserLibrary(int id) async {
  List<AnimeItem> animeList = [];

  final url = 'https://kitsu.io/api/edge/users/$id/library-entries';

  try {
    final libraryResponse = await HTTP.get(Uri.parse(url));

    if (libraryResponse.statusCode == 200) {
      final jsonLibraryList = convert.jsonDecode(libraryResponse.body) as Map<String, dynamic>;

      final animeCount = jsonLibraryList['meta']['count'];

      // logic of composing anime list:
      //    1) if there are 1 to 10 animes, then just push them to list
      //    2) if there are more than 10 animes, then push top-10 animes and one more "service" anime,
      //    which has id equals -1
      //    3) if there are no animes, do nothing
      // this logic helps to show info for user

      // fetching anime from library entries list

      int i = 0;
      var animeResponse;
      Map<String, dynamic> animeJson;
      while (i < 10 && i < animeCount) {
        animeResponse = await HTTP
            .get(Uri.parse(jsonLibraryList['data'][i]['relationships']['anime']['links']['related']));
        animeJson = convert.jsonDecode(animeResponse.body) as Map<String, dynamic>;

        if (animeJson['data'] != null) animeList.add(AnimeItem.fromJson(animeJson['data']));
        i++;
      }

      if (animeCount > 10) animeList.add(AnimeItem(id: -1));
    } else {
      print('Request failed with status: ${libraryResponse.statusCode}.');
    }
  } on SocketException {
    // if there is problem with network, then push "service" anime as only element in animeList
    return animeList..add(AnimeItem(id: -1));
  }

  return animeList;
}

//https://kitsu.io/api/edge/anime?filter[text]=guts&page[limit]=10&page[offset]=20

Future<List<AnimeItem>> searchAnimeUsingFilters(String query) async {
  final url = 'https://kitsu.io/api/edge/anime?$query';

  List<AnimeItem> animeList = [];

  try {
    final response = await HTTP.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonAnimeList = convert.jsonDecode(response.body) as Map<String, dynamic>;

      final animeCount = jsonAnimeList['meta']['count'];

      // logic of composing anime list:
      //    1) add all anime from response to list
      //    2) add "service" anime to the end, id of it is -1, title is applied filter(query),
      //    episodeCount is count of results in request(animeCount)
      //    3) if there are no animes, do nothing
      // this logic helps to show info for user

      // TODO - rewrite according of comments above

      if (animeCount <= 10) {
        for (int i = 0; i < animeCount; i++) {
          animeList.add(AnimeItem.fromJson(jsonAnimeList['data'][i]));
        }
      } else {
        for (int i = 0; i < 10; i++) {
          animeList.add(AnimeItem.fromJson(jsonAnimeList['data'][i]));
        }
        animeList.add(AnimeItem(id: -1, title: query, episodeCount: animeCount));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return animeList;
  } on SocketException {
    return animeList..add(AnimeItem(id: -1));
  }
}
