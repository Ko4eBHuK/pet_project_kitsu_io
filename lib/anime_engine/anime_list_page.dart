import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'animeItem.dart';

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
    List<AnimeItem> animeList = ModalRoute.of(context)!.settings.arguments as List<AnimeItem>;
    String appBarText = '';

    if (animeList.length > 10) {
      appBarText = 'Top-10 results';
      animeList.removeAt(animeList.length - 1);
    } else
      appBarText = 'There are ${animeList.length} results';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //TODO - connect content with request result
          //this algorithm compute how to show items in anime list

          //  this is list of a rows that collects animeCards
          List<Row> rowList = [];

          double cardHeight = 200.0;
          double cardWidth = 160.0;

          //  this list contains cards, which represent each anime in kitsu.io server response
          final animeCardList = List<AnimeCard>.generate(animeList.length, (index) {
            return AnimeCard(animeList[index], cardHeight, cardWidth);
          });

          //  max items in row
          int itemCountInRow = constraints.maxWidth ~/ cardWidth;

          //  demandable number of rows
          int rowCount = animeCardList.length ~/ itemCountInRow;
          if (animeCardList.length % itemCountInRow != 0) rowCount++;

          //  fill rows with animeCards
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
          //end of algorithm

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
