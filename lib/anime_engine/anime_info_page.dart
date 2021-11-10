import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/anime_engine/animeItem.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeInfoPage extends StatelessWidget {
  const AnimeInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimeItem anime = ModalRoute.of(context)!.settings.arguments as AnimeItem;
    double columnWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: Text('${anime.title}'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  // TODO - fill anime info page with content
                  ElevatedButton(
                    onPressed: () async {
                      await canLaunch('https://kitsu.io/anime/${anime.slug}')
                          ? await launch('https://kitsu.io/anime/${anime.slug}')
                          : throw 'Could not launch https://kitsu.io/anime/${anime.slug}';
                    },
                    child: Text('Open in browser'),
                  ),
                  Center(
                    child: SizedBox(
                      width: columnWidth,
                      child: Text('${anime.description}'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
