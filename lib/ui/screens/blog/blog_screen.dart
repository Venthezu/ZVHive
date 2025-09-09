import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Blog', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF12151B),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                'Blog Post ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'This is a sample blog post description...',
                style: TextStyle(color: Colors.grey[400]),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Navigate to blog detail
              },
            ),
          );
        },
      ),
    );
  }
}