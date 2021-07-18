import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _sizedBoxHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: _sizedBoxHeight,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/UserSearch');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('User search'),
                ),
              ),
            ),
            SizedBox(
              height: _sizedBoxHeight,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/AnimeSearch');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Anime search'),
                ),
              ),
            ),
            SizedBox(
              height: _sizedBoxHeight,
            ),
          ],
        ),
      ),
    );
  }
}
