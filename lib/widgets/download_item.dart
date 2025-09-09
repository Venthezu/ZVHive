import 'package:flutter/material.dart';

class DownloadItem extends StatelessWidget {
  final String quality;
  final String size;
  final String format;
  final VoidCallback onDownload;

  const DownloadItem({
    super.key,
    required this.quality,
    required this.size,
    required this.format,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12151B),
      child: ListTile(
        leading: const Icon(Icons.download, color: Colors.green),
        title: Text(
          '$quality • $format',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          size,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: ElevatedButton(
          onPressed: onDownload,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6D28D9),
            foregroundColor: Colors.white,
          ),
          child: const Text('Download'),
        ),
      ),
    );
  }
}