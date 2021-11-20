import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'anime_item_card.dart';
import 'AnimeItem.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  Widget generateCardList(List<AnimeItem> animeList) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //this algorithm compute how to show items in anime list

        //  this is list of a rows that collects animeCards
        List<Row> rowList = [];

        double cardHeight = 200.0;
        double cardWidth = 170.0;

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

        return Column(
          children: rowList,
        );
      },
    );
  }

  Widget _animeListColumn = Column();

  List<AnimeCard> animeCardList = [];
  AnimeItem anime = AnimeItem();

  // TODO - add infinite load list (may use side lib)
  @override
  Widget build(BuildContext context) {
    List<AnimeItem> animeList = ModalRoute.of(context)!.settings.arguments as List<AnimeItem>;

    _animeListColumn = generateCardList(animeList);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Anime list'),
            // test how to add anime to list and show it
            TextButton(
              child: Text('Add 1 item'),
              onPressed: () {
                setState(() {
                  animeList.add(animeList[0]);
                  _animeListColumn = generateCardList(animeList);
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _animeListColumn,
      ),
    );
  }
}
