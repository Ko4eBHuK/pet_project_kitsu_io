import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project_kitsu_io/anime_engine/animeItem.dart';
import 'package:pet_project_kitsu_io/user_engine/user_info_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

class AnimeInfoPage extends StatelessWidget {
  const AnimeInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimeItem anime = ModalRoute.of(context)!.settings.arguments as AnimeItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title != null ? anime.title! : 'No title'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Description
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            iconColor: Colors.grey,
                          ),
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Description',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          collapsed: Column(
                            children: [
                              const Divider(
                                color: Colors.purpleAccent,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  anime.description != null ? anime.description! : 'No description',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          expanded: Column(
                            children: [
                              const Divider(
                                color: Colors.purpleAccent,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  anime.description != null ? anime.description! : 'No description',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  // Info
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.grey,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Information',
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        collapsed: const Divider(
                          color: Colors.purpleAccent,
                          thickness: 1,
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: Colors.purpleAccent,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                'Title: ${anime.title != null ? anime.title : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Rating: ${anime.rating != null ? anime.rating : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Age rating: ${anime.ageRating != null ? anime.ageRating : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Start date: ${anime.startDate != null ? anime.startDate : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Episode count: ${anime.episodeCount != null ? anime.episodeCount : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Episode length: ${anime.episodeLength != null ? anime.episodeLength : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 8),
                              child: Text(
                                'Show type: ${anime.showType != null ? anime.showType : 'no info'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Poster image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.grey,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Poster',
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        collapsed: const Divider(
                          color: Colors.purpleAccent,
                          thickness: 1,
                        ),
                        expanded: Column(
                          children: [
                            const Divider(
                              color: Colors.purpleAccent,
                              thickness: 1,
                            ),
                            showNetworkImage(anime.posterImageLink),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Cover image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconColor: Colors.grey,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cover',
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        collapsed: const Divider(
                          color: Colors.purpleAccent,
                          thickness: 1,
                        ),
                        expanded: Column(
                          children: [
                            const Divider(
                              color: Colors.purpleAccent,
                              thickness: 1,
                            ),
                            showNetworkImage(anime.coverImageLing),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Open in browser button
                  ElevatedButton(
                    onPressed: () async {
                      await canLaunch('https://kitsu.io/anime/${anime.slug}')
                          ? await launch('https://kitsu.io/anime/${anime.slug}')
                          : throw 'Could not launch https://kitsu.io/anime/${anime.slug}';
                    },
                    child: Text('Open in browser'),
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
