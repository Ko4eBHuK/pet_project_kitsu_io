import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_project_kitsu_io/anime_engine/AnimeItem.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';
import 'package:pet_project_kitsu_io/services/show_image_logic.dart';
import 'package:pet_project_kitsu_io/user_engine/user.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Widget _libraryButtonNeighbour = Container();

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    final _basicTextStyle = TextStyle(
      fontSize: 18,
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
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _libraryButtonNeighbour,
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _libraryButtonNeighbour = SpinKitWave(
                                  color: Colors.white,
                                  size: 50.0,
                                );
                              });

                              // request performs here
                              List<AnimeItem> responsedAnimeList =
                                  await searchAnimeUserLibrary(currentUser.id);

                              setState(() {
                                _libraryButtonNeighbour = Container();
                              });

                              if (responsedAnimeList.length != 0) {
                                if (responsedAnimeList[0].id != -1) {
                                  Navigator.pushNamed(
                                    context,
                                    '/AnimeSearch/Results',
                                    arguments: responsedAnimeList,
                                  );
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Internet connection error'),
                                      content: const Text('Check your network'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Anime not found'),
                                    content:
                                        Text('There are no anime in ${currentUser.name}\'s library'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Show user\'s library',
                              style: _basicTextStyle,
                            ),
                          ),
                          _libraryButtonNeighbour,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(_basicTextPadding),
                    child: Card(
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          Text('${currentUser.name}\'s avatar'),
                          const Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          showNetworkImage(currentUser.avatarImageLink),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(_basicTextPadding),
                    child: Card(
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          Text('${currentUser.name}\'s cover'),
                          const Divider(
                            color: Colors.purpleAccent,
                            thickness: 1,
                          ),
                          showNetworkImage(currentUser.coverImageLink),
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
