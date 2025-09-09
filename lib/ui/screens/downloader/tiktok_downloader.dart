import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/download_provider.dart';

class TikTokDownloader extends StatefulWidget {
  const TikTokDownloader({super.key});

  @override
  State<TikTokDownloader> createState() => _TikTokDownloaderState();
}

class _TikTokDownloaderState extends State<TikTokDownloader> {
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
      await downloadProvider.downloadTikTok(_urlController.text.trim());
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
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'TikTok URL',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1F2E),
                prefixIcon: const Icon(Icons.link, color: Colors.grey),
                hintText: 'https://tiktok.com/@username/video/...',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a TikTok URL';
                }
                if (!value.contains('tiktok.com')) {
                  return 'Please enter a valid TikTok URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
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
                  : const Text('Download TikTok Video'),
            ),

            if (downloadProvider.downloadResult != null)
              _DownloadResult(result: downloadProvider.downloadResult!),

            if (downloadProvider.error != null)
              _ErrorDisplay(error: downloadProvider.error!),
          ],
        ),
      ),
    );
  }
}

class _DownloadResult extends StatelessWidget {
  final dynamic result;

  const _DownloadResult({required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
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
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result['title'] ?? 'Unknown Title',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Handle download
            },
            child: const Text('Download Now'),
          ),
        ],
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String error;

  const _ErrorDisplay({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.red[900]!.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        error,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}