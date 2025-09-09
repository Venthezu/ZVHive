import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BlogDetailScreen extends StatelessWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text(
          'Blog Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blog Title
              const Text(
                'The Ultimate Guide to Reading Comics on Mobile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Blog Metadata
              const Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'January 15, 2024',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.timer, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    '5 min read',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Blog Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://example.com/blog-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Blog Content
              MarkdownBody(
                data: '''
# The Ultimate Guide to Reading Comics on Mobile

In today's digital age, reading comics has never been easier. With the rise of mobile applications, comic enthusiasts can now carry their entire collection in their pocket. 

## Why Read Comics on Mobile?

### 📱 Portability
Never leave your comics behind. Your entire library is available anytime, anywhere.

### 🌙 Reading Comfort
Adjust brightness, text size, and background color for optimal reading in any lighting condition.

### ⚡ Instant Access
Download new chapters instantly and get notified when your favorite series updates.

## Best Practices for Mobile Reading

### 1. **Use Dark Mode**
Reduce eye strain by using dark mode, especially when reading at night.

### 2. **Download for Offline Reading**
Save your favorite comics for offline access when you're on the go.

### 3. **Organize Your Library**
Use collections and tags to keep your comics organized.

## Technical Tips

```dart
// Example code for comic reader functionality
void navigateToComic(String comicId, int chapter) {
  // Navigation logic here
}
Conclusion
​Mobile comic reading offers unparalleled convenience and accessibility. With the right app and settings, you can enjoy your favorite comics wherever you are.
​Happy reading! 📚 ''',
styleSheet: MarkdownStyleSheet(
p: const TextStyle(
color: Colors.white70,
fontSize: 16,
height: 1.6,
),
h1: const TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
height: 1.3,
),
h2: const TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
height: 1.3,
),
h3: const TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
height: 1.3,
),
code: TextStyle(
backgroundColor: Colors.grey[900],
color: Colors.white,
fontFamily: 'Monospace',
fontSize: 14,
),
blockquote: TextStyle(
color: Colors.grey[400],
fontStyle: FontStyle.italic,
backgroundColor: Colors.grey[900]!.withOpacity(0.3),
padding: const EdgeInsets.all(16),
),
),
),
const SizedBox(height: 30),
],
),
),
),
);
}
}