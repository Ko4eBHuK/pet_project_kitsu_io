import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/user_engine/user_class.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameTextController = TextEditingController();
  static const _secondColor = Color(0xffff6090);

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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(
                          context,
                          '/UserSearch/Result',
                          arguments: User(
                              1,
                              'test_name',
                              'test_location',
                              'test_bDay',
                              'test_gender',
                              'test_waifuOrHusbando',
                              'test_avatarImageLink',
                              'test_coverImageLink',
                              'test_waifuLink',
                              'test_HusbandoLink',
                              'test_libraryEntriesLink'),
                        );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
