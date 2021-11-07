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
                image: _anime.posterImageLink != null
                    ? NetworkImage(_anime.posterImageLink!)
                    : Image.asset('images/no_photo.png').image,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            // TODO - make labels nice looking
            child: Center(
              child: Text('${_anime.title}\nRating: ${_anime.rating}'),
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
