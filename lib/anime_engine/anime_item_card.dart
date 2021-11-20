import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AnimeItem.dart';

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
          splashColor: const Color(0xff4a0072).withAlpha(200),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/AnimeSearch/Item',
              arguments: _anime,
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: _anime.posterImageLink != null
                    ? Image.network(_anime.posterImageLink!).image
                    : Image.asset('images/no_photo.png').image,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff4a0072).withOpacity(0.8),
                ),
                child: Text(
                  '${_anime.title}\nRating: ${_anime.rating}',
                  textAlign: TextAlign.center,
                ),
                width: _width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
