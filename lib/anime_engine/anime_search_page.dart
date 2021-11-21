import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';
import 'AnimeItem.dart';

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

  DateTime _yearFilterSelectedDate = DateTime.now();

  bool _yearHasBeenChanged = false;

  final Widget _divider = Divider(
    color: Colors.purpleAccent,
    thickness: 1,
  );

  Widget _searchButtonNeighbour = Container();

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

  String _composeFilters() {
    // to return results in rating from TOP-1 to TOP-10 by user rating
    String query = 'sort=-averageRating';

    // composing text filter part to query
    final textFilterRequestString = textFilterController.text;
    if (textFilterRequestString.length > 0) {
      query += '&filter[text]=';
      query += textFilterRequestString.replaceAll(' ', '+');
    }

    // composing age rating filter part
    if (_ageRatingMap.values.contains(true)) {
      query += '&filter[ageRating]=';
      _ageRatingMap.forEach((key, value) {
        if (value!) query += key + ',';
      });
      query = query.substring(0, query.length - 1);
    }

    // composing streamers filter part
    if (_streamersMap.values.contains(true)) {
      query += '&filter[streamers]=';
      _streamersMap.forEach((key, value) {
        if (value!) query += key + ',';
      });
      query = query.substring(0, query.length - 1);
    }

    // composing year filter part
    if (_yearHasBeenChanged) {
      query += '&filter[seasonYear]=${_yearFilterSelectedDate.year}';
    }

    return query;
  }

  @override
  void dispose() {
    textFilterController.dispose();
    super.dispose();
  }

  // TODO - redo of design
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Anime filters:',
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                        ),
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
                                // TODO - make text tappable as checkbox
                                Text('Age rating'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _createAgeRatingFilterRowChildren(),
                                ),
                                _divider,
                                Container(
                                  child: Column(
                                    children: [
                                      // TODO - make text tappable as checkbox
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
                      // "Search" button row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _searchButtonNeighbour,
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _searchButtonNeighbour = SpinKitWave(
                                  color: Colors.white,
                                  size: 50.0,
                                );
                              });

                              // request performs here
                              List<AnimeItem> responsedAnimeList =
                                  await searchAnimeUsingFilters(_composeFilters());

                              setState(() {
                                _searchButtonNeighbour = Container();
                              });

                              if (responsedAnimeList.length != 0) {
                                if (responsedAnimeList[0].id != -1) {
                                  Navigator.pushNamed(
                                    context,
                                    animeSearchResultRoute,
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
                                    content: const Text(
                                        'No anime corresponds with your filters, anyway you may try again :3'),
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
                              'Search',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          _searchButtonNeighbour,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
