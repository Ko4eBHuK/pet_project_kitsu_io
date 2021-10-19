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

      // TODO - распарсить ответ и отдать на вьюху

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return AnimeList;
  } on SocketException {
    return AnimeList;
  }
}

// TODO - develop anime search engine
//example of multi-filter request
//https://kitsu.io/api/edge/anime?filter[ageRating]=PG,R,R18&filter[season]=winter
