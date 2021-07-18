import 'package:flutter/material.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final usernameTextController = TextEditingController();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameTextController,
                  style: TextStyle(
                    color: Color(0xffff6090),
                    fontSize: 22,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 22),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Enter username for get details',
                    icon: Icon(
                      Icons.person,
                      color: Color(0xffff6090),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
