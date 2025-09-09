import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String content;
  final List<String> images;
  final int likes;
  final int comments;
  final String timeAgo;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    super.key,
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.images,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12151B),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Content
            if (content.isNotEmpty)
              Text(
                content,
                style: const TextStyle(color: Colors.white),
              ),

            // Images
            if (images.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Actions
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: onLike,
                ),
                Text('$likes', style: const TextStyle(color: Colors.grey)),
                
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.grey),
                  onPressed: onComment,
                ),
                Text('$comments', style: const TextStyle(color: Colors.grey)),
                
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.grey),
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}