import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/user_engine/user_class.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameTextController = TextEditingController();
  static const _secondColor = Color(0xffff6090);
  List<Widget> loadingColumnChildren = [];

  @override
  void dispose() {
    usernameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameTextController,
                  style: TextStyle(
                    color: _secondColor,
                    fontSize: 22,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 22),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Enter username for get details',
                    icon: Icon(
                      Icons.person,
                      color: _secondColor,
                      size: 40,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'This field should contain something';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loadingColumnChildren.clear();
                              loadingColumnChildren.add(
                                SpinKitWave(
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              );
                            });

                            Future searchableUser =
                                searchUserByName('https://kitsu.io/api/edge/users?filter[name]=${usernameTextController.text}');

                            searchableUser.then((readyUser) {
                              setState(() {
                                loadingColumnChildren.clear();
                              });

                              User findedUser = readyUser;

                              if (findedUser.id != 0) {
                                Navigator.pushNamed(
                                  context,
                                  '/UserSearch/Result',
                                  arguments: readyUser,
                                );
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('User not found'),
                                    content: const Text('User with this nickname does not exist, anyway you may try again :3'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                          }
                        },
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: loadingColumnChildren,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
