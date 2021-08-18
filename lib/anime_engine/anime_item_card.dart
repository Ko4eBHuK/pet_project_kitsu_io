import 'package:flutter/material.dart';
import 'animeItem.dart';

class AnimeCard extends StatelessWidget {
  late final AnimeItem _anime;
  late final double _height;
  late final double _width;

  AnimeCard(AnimeItem anime, double height, double width) {
    _anime = anime;
    _height = height;
    _width = width;
  }

  // TODO - finish card view

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      child: Card(
        child: InkWell(
          splashColor: Colors.red.withAlpha(100),
          onTap: () {
            print('tap on anime_card');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                //image: NetworkImage(_anime.posterImageLink!),
                image: NetworkImage('https://media.kitsu.io/anime/poster_images/1/original.jpg?1597604210'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: Text('some anime content'),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
