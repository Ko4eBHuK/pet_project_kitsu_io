import 'package:flutter/material.dart';
import 'animeItem.dart';

class AnimeCard extends StatelessWidget {
  late final AnimeItem _anime;

  AnimeCard(AnimeItem anime) {
    _anime = anime;
  }

  // TODO - finish card view

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 340,
      child: Card(
        child: InkWell(
          splashColor: Colors.red.withAlpha(100),
          onTap: () {
            print('tap on anime_card');
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_anime.posterImageLink!),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Text('some anime content'),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
