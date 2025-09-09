import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/download_provider.dart';

class InstagramDownloader extends StatefulWidget {
  const InstagramDownloader({super.key});

  @override
  State<InstagramDownloader> createState() => _InstagramDownloaderState();
}

class _InstagramDownloaderState extends State<InstagramDownloader> {
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
      await downloadProvider.downloadInstagram(_urlController.text.trim());
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
                labelText: 'Instagram URL',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1F2E),
                prefixIcon: const Icon(Icons.link, color: Colors.grey),
                hintText: 'https://instagram.com/p/...',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an Instagram URL';
                }
                if (!value.contains('instagram.com')) {
                  return 'Please enter a valid Instagram URL';
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
                  : const Text('Download Instagram Content'),
            ),
          ],
        ),
      ),
    );
  }
}