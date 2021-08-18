import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'animeItem.dart';
import 'package:pet_project_kitsu_io/services/request_engine.dart';

//TODO - create filter page here

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({Key? key}) : super(key: key);

  @override
  _AnimeSearchPageState createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final filtersTextController = TextEditingController();

  @override
  void dispose() {
    filtersTextController.dispose();
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
          //test area
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/AnimeSearch/Results',
                            );
                          },
                          icon: Icon(Icons.whatshot_outlined),
                          iconSize: 280.0,
                        ),
                      ],
                    ),
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
