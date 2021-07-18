import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/user_engine/user_class.dart';
import 'dart:convert' as convert;

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
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15),
        children: [
          Column(
            children: [
              Card(
                color: Color(0xff102027),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                      child: Text(
                        'User\'s name: ${currentUser.name}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                      child: Text(
                        'User\'s birth date: ${currentUser.bDay}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: _basicTextPadding, right: _basicTextPadding, top: _basicTextPadding),
                      child: Text(
                        'User\'s gender: ${currentUser.gender}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(_basicTextPadding),
                      child: Text(
                        'User\'s waifu: ${currentUser.waifuLink}',
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
                  child: TextButton(
                    //TODO make anime list business and connect it here
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff4a0072),
                      ),
                    ),
                    child: Text(
                      'Show user\'s library',
                      style: TextStyle(
                        color: Color(0xffff6090),
                        fontSize: 18,
                      ),
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
                      currentUser.avatarImageLink == 'no image'
                          ? Image.asset('images/no_photo.png')
                          : Image.network(currentUser.avatarImageLink),
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
                      currentUser.coverImageLink == 'no image'
                          ? Image.asset('images/no_photo.png')
                          : Image.network(currentUser.coverImageLink),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
