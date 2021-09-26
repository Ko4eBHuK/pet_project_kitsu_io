import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'animeItem.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//TODO - compose all filters and do a request

//possible filters:
/*
  [text]=One%20Punch%20Man
  [ageRating]=G / PG,R,R18
  [streamers]=Hulu,Funimation,Crunchyroll,CONtv,Netflix,HIDIVE,TubiTV,Amazon,YouTube,AnimeLab,VRV
  [season]=winter, spring, summer, fall
  [seasonYear]=2017
*/

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({Key? key}) : super(key: key);

  @override
  _AnimeSearchPageState createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const _accentColor = Color(0xffff6090);
  final textFilterController = TextEditingController();

  Map<String, bool?> _ageRatingMap = {'G': false, 'PG': false, 'R': false, 'R18': false};

  Map<String, bool?> _streamersMap = {
    'Hulu': false,
    'Funimation': false,
    'Crunchyroll': false,
    'CONtv': false,
    'Netflix': false,
    'HIDIVE': false,
    'TubiTV': false,
    'Amazon': false,
    'YouTube': false,
    'AnimeLab': false,
    'VRV': false
  };

  Map<String, bool?> _seasonsMap = {'winter': false, 'spring': false, 'summer': false, 'fall': false};

  DateTime _yearFilterSelectedDate = DateTime.now();

  bool _yearHasBeenChanged = false;

  List<Widget> _createAgeRatingFilterRowChildren() {
    return new List<Widget>.generate(
      _ageRatingMap.length,
      (int index) {
        return Container(
          child: Row(
            children: [
              Checkbox(
                value: _ageRatingMap.values.elementAt(index),
                onChanged: (bool? newVal) {
                  setState(() {
                    _ageRatingMap[_ageRatingMap.keys.elementAt(index)] = newVal;
                  });
                },
              ),
              Text(_ageRatingMap.keys.elementAt(index)),
            ],
          ),
        );
      },
    );
  }

  Widget _divider = Divider(
    color: Colors.purpleAccent,
    thickness: 1,
  );

  var _spinWaveColor = Colors.white10;

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
                      // Column with "Search" button and title
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SpinKitWave(
                                color: _spinWaveColor,
                                size: 50.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _spinWaveColor = Colors.white;
                                  });

                                  print(_ageRatingMap);
                                  print(_streamersMap);
                                  print(_seasonsMap);
                                  print(_yearHasBeenChanged);
                                  print(_yearFilterSelectedDate);

                                  setState(() {
                                    _spinWaveColor = Colors.white10;
                                  });
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
                              SpinKitWave(
                                color: _spinWaveColor,
                                size: 50.0,
                              ),
                            ],
                          ),
                          Text(
                            'Anime filters:',
                            style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox with scrollable list of anime filters
                      //   this SizedBox here for the reason to give the "Search" button a fixed position
                      SizedBox(
                        height: constraints.maxHeight * 0.78,
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white10,
                            child: Column(
                              children: [
                                // filter that allows to select animes with defined words
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
                                Text('Age rating'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _createAgeRatingFilterRowChildren(),
                                ),
                                _divider,
                                Container(
                                  child: Column(
                                    children: [
                                      Text('Streamers'),
                                      ListView.builder(
                                        itemCount: _streamersMap.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return ListTile(
                                            leading: Checkbox(
                                              value: _streamersMap.values.elementAt(index),
                                              onChanged: (bool? newVal) {
                                                setState(() {
                                                  _streamersMap[_streamersMap.keys.elementAt(index)] =
                                                      newVal;
                                                });
                                              },
                                            ),
                                            title: Text(_streamersMap.keys.elementAt(index)),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                _divider,
                                Text('Year'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 180,
                                    height: 180,
                                    color: Colors.white12,
                                    child: YearPicker(
                                      firstDate: DateTime(1907),
                                      lastDate: DateTime(DateTime.now().year),
                                      selectedDate: _yearFilterSelectedDate,
                                      onChanged: (DateTime dateTime) {
                                        setState(() {
                                          _yearFilterSelectedDate = dateTime;
                                          if (!_yearHasBeenChanged) _yearHasBeenChanged = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                _divider,
                              ],
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
          //test area
        },
      ),
    );
  }
}
