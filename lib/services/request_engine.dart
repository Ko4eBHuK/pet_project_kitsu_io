import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '/user_engine/user.dart';
import '/anime_engine/animeItem.dart';

Future<User> searchUserByName(String userName) async {
  var url = Uri.parse('https://kitsu.io/api/edge/users?filter[name]=$userName');

  User gettedUser = User();

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      if (jsonResponse['meta']['count'] >= 1) {
        gettedUser = User.fromJson(jsonResponse);

        var waifuResponse =
            await http.get(Uri.parse('https://kitsu.io/api/edge/users/${gettedUser.id}/waifu'));
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
  List<AnimeItem> AnimeList = [];

  final url = 'https://kitsu.io/api/edge/users/$id/library-entries';

  try {
    final libraryResponse = await http.get(Uri.parse(url));

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
        animeResponse = await http
            .get(Uri.parse(jsonLibraryList['data'][i]['relationships']['anime']['links']['related']));
        animeJson = convert.jsonDecode(animeResponse.body) as Map<String, dynamic>;

        AnimeList.add(AnimeItem.fromJson(animeJson['data']));
        i++;
      }

      if (animeCount > 10) AnimeList.add(AnimeItem());
    } else {
      print('Request failed with status: ${libraryResponse.statusCode}.');
    }
  } on SocketException {
    return AnimeList..add(AnimeItem());
  }

  return AnimeList;
}

Future<List<AnimeItem>> searchAnimeUsingFilters(String query) async {
  final url = 'https://kitsu.io/api/edge/anime?$query';

  List<AnimeItem> AnimeList = [];

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonAnimeList = convert.jsonDecode(response.body) as Map<String, dynamic>;

      final animeCount = jsonAnimeList['meta']['count'];

      // logic of composing anime list:
      //    1) if there are 1 to 10 animes, then just push them to list
      //    2) if there are more than 10 animes, then push top-10 animes and one more "service" anime,
      //    which has id equals -1
      //    3) if there are no animes, do nothing
      // this logic helps to show info for user

      if (animeCount <= 10) {
        for (int i = 0; i < animeCount; i++) {
          AnimeList.add(AnimeItem.fromJson(jsonAnimeList['data'][i]));
        }
      } else {
        for (int i = 0; i < 10; i++) {
          AnimeList.add(AnimeItem.fromJson(jsonAnimeList['data'][i]));
        }
        AnimeList.add(AnimeItem());
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return AnimeList;
  } on SocketException {
    return AnimeList..add(AnimeItem());
  }
}
