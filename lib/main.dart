import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'user_search_page.dart';
import 'anime_search_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KITSU.IO',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff4a0072),
        accentColor: Color(0xffff6090),
        buttonColor: Color(0xffff6090),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff4a0072),
            onPrimary: Colors.white,
            shadowColor: Colors.pinkAccent,
            elevation: 15,
            textStyle: TextStyle(
              fontSize: 25,
            ),
            side: BorderSide(color: Colors.white54, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        hintColor: Color(0xffff6090),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Color(0xffff6090),
          backgroundColor: Color(0xff4a0072),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: 'KITSU.IO APP home page'),
        '/UserSearch': (context) => UserSearchPage(),
        '/AnimeSearch': (context) => AnimeSearchPage(),
      },
    );
  }
}
