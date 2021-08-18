import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'animeItem.dart';

//TODO - connect content with request result

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final filtersTextController = TextEditingController();

  @override
  void dispose() {
    filtersTextController.dispose();
    super.dispose();
  }

  List<AnimeCard> animeCardList = [];
  AnimeItem anime = AnimeItem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Search'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //test area
          List<AnimeCard> animeCardList = [];
          AnimeItem anime = AnimeItem();
          List<Row> rowList = [];
          double cardHeight = 200.0;
          double cardWidth = 160.0;

          while (animeCardList.length < 7) animeCardList.add(AnimeCard(anime, cardHeight, cardWidth));

          int itemCountInRow = constraints.maxWidth ~/ cardWidth;

          int rowCount = animeCardList.length ~/ itemCountInRow;
          if (animeCardList.length % itemCountInRow != 0) rowCount++;

          for (int i = 0; i < rowCount; i++) {
            rowList.add(
              Row(
                children: animeCardList.sublist(
                  i * itemCountInRow,
                  i * itemCountInRow + itemCountInRow > animeCardList.length
                      ? animeCardList.length
                      : i * itemCountInRow + itemCountInRow,
                ),
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: rowList,
            ),
          );

          //test area
        },
      ),
    );
  }
}
