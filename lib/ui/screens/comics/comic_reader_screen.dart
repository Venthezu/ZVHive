import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ComicReaderScreen extends StatefulWidget {
  final String comicId;
  final int chapterNumber;

  const ComicReaderScreen({
    super.key,
    required this.comicId,
    required this.chapterNumber,
  });

  @override
  State<ComicReaderScreen> createState() => _ComicReaderScreenState();
}

class _ComicReaderScreenState extends State<ComicReaderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _totalPages = 10; // Sample total pages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Comic Pages
          PageView.builder(
            controller: _pageController,
            itemCount: _totalPages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Toggle UI visibility
                },
                child: CachedNetworkImage(
                  imageUrl: "https://example.com/page${index + 1}.jpg",
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),

          // App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.black54,
              foregroundColor: Colors.white,
              title: Text(
                'Chapter ${widget.chapterNumber} - Page ${_currentPage + 1}/$_totalPages',
                style: const TextStyle(fontSize: 16),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Page Indicator (bottom)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentPage + 1} / $_totalPages',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Navigation Controls
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white54, size: 30),
              onPressed: _currentPage > 0
                  ? () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 30),
              onPressed: _currentPage < _totalPages - 1
                  ? () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}