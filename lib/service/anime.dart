import 'package:flutter/material.dart';
import 'package:project/service/api_anime.dart';
import 'package:project/service/detail.dart';
import 'package:project/service/tile.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePage();
}

class _AnimePage extends State<AnimePage> {
  @override
  void initState() {
    AnimeApi.fetchAnimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AnimeApi.fetchAnimes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data != null) {
          final animes = snapshot.data!;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  final anime = animes.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AnimeDetailScreen(anime: anime),
                        ),
                      );
                    },
                    child: AnimeTile(anime: anime),
                  );
                },
              ),
            ),
          );
        }

        return Center(child: Text(snapshot.error.toString()));
      },
    );
  }
}
