import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/comic_provider.dart';
import 'comic_reader_screen.dart';

class ComicDetailScreen extends StatefulWidget {
  final String comicId;

  const ComicDetailScreen({super.key, required this.comicId});

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ComicProvider>(context, listen: false).getComic(widget.comicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final comicProvider = Provider.of<ComicProvider>(context);
    // In real app, you'd get the actual comic from provider

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Comic Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: comicProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Comic Cover
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFF12151B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "https://example.com/cover.jpg", // Replace with actual URL
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: Icon(Icons.book, size: 60, color: Colors.grey),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Comic Info
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comic Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Manhwa • 25 Chapters',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description: This is a sample comic description that explains what the comic is about. It can be multiple lines long.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Chapters List
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Chapters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Sample Chapters
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final chapterNumber = index + 1;
                      return ListTile(
                        leading: const Icon(Icons.chrome_reader_mode, color: Colors.grey),
                        title: Text(
                          'Chapter $chapterNumber',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '2 days ago',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComicReaderScreen(
                                comicId: widget.comicId,
                                chapterNumber: chapterNumber,
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