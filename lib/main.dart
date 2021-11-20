import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'user_engine/user_search_page.dart';
import 'user_engine/user_info_page.dart';
import 'anime_engine/anime_search_page.dart';
import 'anime_engine/anime_list_page.dart';
import 'anime_engine/anime_info_page.dart';

// TODO - apply conventions to source code, make routes as constants
const String rootRoute = '/';
const String userSearchRoute = '/UserSearch';
const String animeSearchRoute = '/AnimeSearch';
const String userSearchResultRoute = '/UserSearch/Result';
const String animeSearchResultRoute = '/AnimeSearch/Results';
const String animeItemRoute = '/AnimeSearch/Item';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KITSU.IO',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xff4a0072),
        accentColor: const Color(0xffff6090),
        buttonColor: const Color(0xffff6090),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff4a0072),
            onPrimary: Colors.white,
            shadowColor: Colors.tealAccent,
            elevation: 5,
            textStyle: TextStyle(
              fontSize: 25,
            ),
            side: BorderSide(color: Colors.white54, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        hintColor: const Color(0xffff6090),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: const Color(0xffff6090),
          backgroundColor: const Color(0xff4a0072),
        ),
      ),
      initialRoute: rootRoute,
      routes: {
        rootRoute: (context) => HomePage(title: 'KITSU.IO APP home page'),
        userSearchRoute: (context) => UserSearchPage(),
        animeSearchRoute: (context) => AnimeSearchPage(),
        userSearchResultRoute: (context) => UserInfoPage(),
        animeSearchResultRoute: (context) => AnimeList(),
        animeItemRoute: (context) => AnimeInfoPage(),
      },
    );
  }
}
