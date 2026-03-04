import 'package:flutter/material.dart';
import 'package:project/service/api_anime.dart';
import 'package:project/service/detail.dart';
import 'package:project/service/tile.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  late Future<List<dynamic>> _animeFuture;

  @override
  void initState() {
    super.initState();
    _animeFuture = AnimeApi.fetchAnimes();
  }

  Future<void> _refresh() async {
    setState(() {
      _animeFuture = AnimeApi.fetchAnimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _animeFuture,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong 😢\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          // Empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No anime found"));
          }

          final animes = snapshot.data!;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: animes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final anime = animes[index];

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
        },
      ),
    );
  }
}
