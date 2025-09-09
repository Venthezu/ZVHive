import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/download_provider.dart';

class YouTubeDownloader extends StatefulWidget {
  const YouTubeDownloader({super.key});

  @override
  State<YouTubeDownloader> createState() => _YouTubeDownloaderState();
}

class _YouTubeDownloaderState extends State<YouTubeDownloader> {
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _downloadVideo() async {
    if (_formKey.currentState!.validate()) {
      final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
      await downloadProvider.downloadYouTube(_urlController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final downloadProvider = Provider.of<DownloadProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // URL Input
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'YouTube URL',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1F2E),
                prefixIcon: const Icon(Icons.link, color: Colors.grey),
                hintText: 'https://youtube.com/watch?v=...',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a YouTube URL';
                }
                if (!value.contains('youtube.com') && !value.contains('youtu.be')) {
                  return 'Please enter a valid YouTube URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            // Download Button
            ElevatedButton(
              onPressed: downloadProvider.isLoading ? null : _downloadVideo,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D28D9),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: downloadProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Download Video', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            
            // Result Display
            if (downloadProvider.downloadResult != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF12151B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Download Ready:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      downloadProvider.downloadResult!.title,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    // Add download options here
                  ],
                ),
              ),
            
            if (downloadProvider.error != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[900]!.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  downloadProvider.error!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}