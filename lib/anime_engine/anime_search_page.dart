import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'animeItem.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//TODO - create filter page here

//possible filters:
/*
  [text]=One%20Punch%20Man
  [ageRating]=G / PG,R,R18
  [season]=winter, spring, summer, fall
  [seasonYear]=2017 / 2005,2006
  [streamers]=Hulu,Funimation,Crunchyroll,CONtv,Netflix,HIDIVE,TubiTV,Amazon,YouTube,AnimeLab,VRV
*/

List<String> _seasonOptions = ['Winter', 'Spring', 'Summer', 'Fall'];
List<String> _streamerOptions = [
  'Hulu',
  'Funimation',
  'Crunchyroll',
  'CONtv',
  'Netflix',
  'HIDIVE',
  'TubiTV',
  'Amazon',
  'YouTube',
  'AnimeLab',
  'VRV'
];

var _divider = Divider(
  color: Colors.purpleAccent,
  thickness: 1,
);

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({Key? key}) : super(key: key);

  @override
  _AnimeSearchPageState createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const _accentColor = Color(0xffff6090);
  final textFilterController = TextEditingController();
  bool? _gOption = false;
  bool? _pgOption = false;
  bool? _rOption = false;
  bool? _r18Option = false;
  bool? _HuluOption = false;
  bool? _FunimationOption = false;
  bool? _CrunchyrollOption = false;
  bool? _CONtvOption = false;
  bool? _NetflixOption = false;
  bool? _HIDIVEOption = false;
  bool? _TubiTVOption = false;
  bool? _AmazonOption = false;
  bool? _YouTubeOption = false;
  bool? _AnimeLabOption = false;
  bool? _VRVOption = false;

  @override
  void dispose() {
    textFilterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Search'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SpinKitWave(
                              color: Colors.white,
                              size: 50.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/AnimeSearch/Results',
                                );
                              },
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SpinKitWave(
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Anime filters:',
                              style: TextStyle(
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            _divider,
                            Text('Anime keywords'),
                            TextFormField(
                              controller: textFilterController,
                              style: TextStyle(
                                color: _accentColor,
                                fontSize: 22,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Type any text',
                                labelStyle: TextStyle(fontSize: 18),
                                hintStyle: TextStyle(fontSize: 18),
                                icon: Icon(
                                  Icons.text_fields_sharp,
                                  color: _accentColor,
                                  size: 40,
                                ),
                              ),
                            ),
                            _divider,
                            Container(
                              child: Column(
                                children: [
                                  Text('Age rating'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('G'),
                                            Checkbox(
                                              value: _gOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _gOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('PG'),
                                            Checkbox(
                                              value: _pgOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _pgOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R'),
                                            Checkbox(
                                              value: _rOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _rOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R18'),
                                            Checkbox(
                                              value: _r18Option,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _r18Option = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            _divider,
                            Container(
                              child: Column(
                                children: [
                                  Text('Streamers'),
                                  GridView.count(
                                    crossAxisCount: 2,
                                    primary: false,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    padding: const EdgeInsets.all(10),
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('G'),
                                            Checkbox(
                                              value: _gOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _gOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('PG'),
                                            Checkbox(
                                              value: _pgOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _pgOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R'),
                                            Checkbox(
                                              value: _rOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _rOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R18'),
                                            Checkbox(
                                              value: _r18Option,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _r18Option = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('G'),
                                            Checkbox(
                                              value: _gOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _gOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('PG'),
                                            Checkbox(
                                              value: _pgOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _pgOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R'),
                                            Checkbox(
                                              value: _rOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _rOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R18'),
                                            Checkbox(
                                              value: _r18Option,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _r18Option = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('G'),
                                            Checkbox(
                                              value: _gOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _gOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('PG'),
                                            Checkbox(
                                              value: _pgOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _pgOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text('R'),
                                            Checkbox(
                                              value: _rOption,
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _rOption = newVal;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            _divider,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          //test area
        },
      ),
    );
  }
}
