import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/anime_provider.dart';
import 'anime_player_screen.dart';

class AnimeDetailScreen extends StatefulWidget {
  final String animeId;

  const AnimeDetailScreen({super.key, required this.animeId});

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnimeProvider>(context, listen: false).getAnime(widget.animeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Anime Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Anime Cover
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF12151B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: "https://example.com/anime-cover.jpg",
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: Icon(Icons.movie, size: 60, color: Colors.grey),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 20),
            
            // Anime Info
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anime Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Action • Adventure • 12 Episodes',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description: This is a sample anime description. It tells the story of amazing characters and their adventures in a fantasy world.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Episodes List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Episodes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Sample Episodes
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                final episodeNumber = index + 1;
                return ListTile(
                  leading: const Icon(Icons.play_circle_fill, color: Colors.red),
                  title: Text(
                    'Episode $episodeNumber: The Beginning',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '24 min • 1 week ago',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  trailing: const Icon(Icons.play_arrow, color: Colors.green),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimePlayerScreen(
                          animeId: widget.animeId,
                          episodeNumber: episodeNumber,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}