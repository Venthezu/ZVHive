import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/anime_provider.dart';
import '../../widgets/anime_card.dart';
import 'anime_detail_screen.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnimeProvider>(context, listen: false).loadAnimeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Anime', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: animeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : animeProvider.animeList.isEmpty
              ? const Center(
                  child: Text(
                    'No anime available',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: animeProvider.animeList.length,
                  itemBuilder: (context, index) {
                    final anime = animeProvider.animeList[index];
                    return AnimeCard(
                      anime: anime,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimeDetailScreen(animeId: anime.id),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}