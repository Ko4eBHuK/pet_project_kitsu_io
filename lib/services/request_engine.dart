import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../user_engine/user_class.dart';

Future<User> searchUserByName(String query) async {
  var url = Uri.parse(query);

  var response = await http.get(url);

  User gettedUser = User();

  print('Response status: ${response.statusCode}');

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

    String waifuName = '';

    if (jsonResponse['meta']['count'] == 1) {
      String avatarInfo = jsonResponse['data'][0]['attributes']['avatar'] != null
          ? jsonResponse['data'][0]['attributes']['avatar']['original']
          : 'no image';
      String coverInfo = jsonResponse['data'][0]['attributes']['coverImage'] != null
          ? jsonResponse['data'][0]['attributes']['coverImage']['original']
          : 'no image';

      gettedUser = new User.fromNet(
        int.parse(jsonResponse['data'][0]['id']),
        jsonResponse['data'][0]['attributes']['name'],
        jsonResponse['data'][0]['attributes']['birthday'],
        jsonResponse['data'][0]['attributes']['gender'],
        jsonResponse['data'][0]['attributes']['waifuOrHusbando'],
        avatarInfo,
        coverInfo,
        waifuName,
        jsonResponse['data'][0]['relationships']['libraryEntries']['links']['related'],
      );
    }

    var waifuResponse =
        await http.get(Uri.parse('https://kitsu.io/api/edge/users/${gettedUser.id}/waifu'));
    var waifuJsonResponse = convert.jsonDecode(waifuResponse.body) as Map<String, dynamic>;
    waifuName = waifuJsonResponse['data'] != null
        ? waifuJsonResponse['data']['attributes']['canonicalName']
        : 'no waifu';

    gettedUser.waifuLink = waifuName;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  return gettedUser;
}
