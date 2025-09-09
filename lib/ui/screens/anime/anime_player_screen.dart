import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class AnimePlayerScreen extends StatefulWidget {
  final String animeId;
  final int episodeNumber;

  const AnimePlayerScreen({
    super.key,
    required this.animeId,
    required this.episodeNumber,
  });

  @override
  State<AnimePlayerScreen> createState() => _AnimePlayerScreenState();
}

class _AnimePlayerScreenState extends State<AnimePlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    // Sample video URL - replace with actual video URL from your source
    const String videoUrl = 'https://example.com/sample-video.mp4';
    
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    
    await _videoPlayerController.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: const Color(0xFF6D28D9),
        handleColor: const Color(0xFF3B82F6),
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey[700]!,
      ),
      placeholder: Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      autoInitialize: true,
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // App Bar
                  AppBar(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    title: Text(
                      'Episode ${widget.episodeNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  
                  // Video Player
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Chewie(controller: _chewieController!),
                      ),
                    ),
                  ),
                  
                  // Player Controls
                  Container(
                    color: const Color(0xFF12151B),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous, color: Colors.white),
                          onPressed: () {
                            // Previous episode
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.fast_rewind, color: Colors.white),
                          onPressed: () {
                            _videoPlayerController.seekTo(
                              _videoPlayerController.value.position - const Duration(seconds: 10),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_videoPlayerController.value.isPlaying) {
                                _videoPlayerController.pause();
                              } else {
                                _videoPlayerController.play();
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.fast_forward, color: Colors.white),
                          onPressed: () {
                            _videoPlayerController.seekTo(
                              _videoPlayerController.value.position + const Duration(seconds: 10),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next, color: Colors.white),
                          onPressed: () {
                            // Next episode
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}