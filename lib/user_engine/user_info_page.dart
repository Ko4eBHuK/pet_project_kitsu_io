import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/user_engine/user.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    var _basicTextStyle = TextStyle(
      fontSize: 20,
    );
    const double _basicTextPadding = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  Card(
                    color: Color(0xff102027),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                          child: Text(
                            'User\'s name: ${currentUser.name}',
                            style: _basicTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                          child: Text(
                            'User\'s birth date: ${currentUser.bDay == null ? 'not set' : currentUser.bDay}',
                            style: _basicTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                          child: Text(
                            'User\'s gender: ${currentUser.gender == null ? 'not set' : currentUser.gender}',
                            style: _basicTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(_basicTextPadding),
                          child: Text(
                            'User\'s waifu: ${currentUser.waifuName == null ? 'not set' : currentUser.waifuName}',
                            style: _basicTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(_basicTextPadding),
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO - navigate to anime_list page that connects to user's library (new method in request_engine)
                          // Navigator.pushNamed(
                          //   context,
                          //   '/AnimeSearch/Results',
                          // );
                        },
                        child: Text(
                          'Show user\'s library',
                          style: _basicTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(_basicTextPadding),
                    child: Card(
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          Text('${currentUser.name}\'s avatar'),
                          Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          currentUser.avatarImageLink == null
                              ? Image.asset('images/no_photo.png')
                              : Image.network(currentUser.avatarImageLink!),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(_basicTextPadding),
                    child: Card(
//shape: ,
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          Text('${currentUser.name}\'s cover'),
                          Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          currentUser.coverImageLink == null
                              ? Image.asset('images/no_photo.png')
                              : Image.network(currentUser.coverImageLink!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
