import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/user_engine/user_class.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;

    var _basicTextStyle = TextStyle(
      fontSize: 20,
    );
    const double _basicTextPadding = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
      ),
      body: ListView(
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
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s name: ${args.name}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s location: ${args.location}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s birth date: ${args.bDay}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s gender: ${args.gender}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(_basicTextPadding),
                      child: Text(
                        'User\'s waifu: ${args.waifuLink}',
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
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: Color(0xff102027),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s name: ${args.name}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s location: ${args.location}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s birth date: ${args.bDay}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: _basicTextPadding,
                          right: _basicTextPadding,
                          top: _basicTextPadding),
                      child: Text(
                        'User\'s gender: ${args.gender}',
                        style: _basicTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(_basicTextPadding),
                      child: Text(
                        'User\'s waifu: ${args.waifuLink}',
                        style: _basicTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(_basicTextPadding),
                child: Card(
                  child: Text('${args.avatarImageLink}'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(_basicTextPadding),
                child: Card(
                  child: Text('${args.coverImageLink}'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
