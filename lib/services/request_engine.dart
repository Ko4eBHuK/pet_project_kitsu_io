import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../user_engine/user.dart';

Future<User> searchUserByName(String userName) async {
  var url = Uri.parse('https://kitsu.io/api/edge/users?filter[name]=$userName');

  User gettedUser = User();

  try {
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

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

      var waifuResponse = await http.get(Uri.parse('https://kitsu.io/api/edge/users/${gettedUser.id}/waifu'));
      var waifuJsonResponse = convert.jsonDecode(waifuResponse.body) as Map<String, dynamic>;
      waifuName = waifuJsonResponse['data'] != null ? waifuJsonResponse['data']['attributes']['canonicalName'] : 'no waifu';

      gettedUser.waifuLink = waifuName;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return gettedUser;
  } on SocketException catch (e) {
    print(e.osError);
    gettedUser.id = -1;
    return gettedUser;
  }
}
