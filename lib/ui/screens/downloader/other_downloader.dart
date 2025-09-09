import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/download_provider.dart';

class OtherDownloader extends StatefulWidget {
  const OtherDownloader({super.key});

  @override
  State<OtherDownloader> createState() => _OtherDownloaderState();
}

class _OtherDownloaderState extends State<OtherDownloader> {
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _downloadContent() async {
    if (_formKey.currentState!.validate()) {
      final downloadProvider = Provider.of<DownloadProvider>(context, listen: false);
      await downloadProvider.downloadOther(_urlController.text.trim());
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
                labelText: 'Video URL',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1F2E),
                prefixIcon: const Icon(Icons.link, color: Colors.grey),
                hintText: 'https://example.com/video...',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a video URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: downloadProvider.isLoading ? null : _downloadContent,
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
                  : const Text('Download Video'),
            ),
          ],
        ),
      ),
    );
  }
}