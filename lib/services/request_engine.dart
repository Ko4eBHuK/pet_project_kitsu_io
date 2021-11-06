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

Future<List<AnimeItem>> searchAnimeUsingFilters(String query) async {
  List<AnimeItem> AnimeList = [];

  final url = Uri.parse('https://kitsu.io/api/edge/anime?$query');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonAnimeList = convert.jsonDecode(response.body) as Map<String, dynamic>;

      final animeCount = jsonAnimeList['meta']['count'];

      // TODO - закончить логику формирования листа

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

      print(animeCount);
      AnimeList.forEach((element) {
        print('${element.title} ${element.rating}');
      });

      print(url);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return AnimeList;
  } on SocketException {
    return AnimeList;
  }
}
