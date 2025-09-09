import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/post_model.dart';
import '../../../services/post_service.dart';
import 'create_post_screen.dart';
import 'post_detail_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      // In real app, fetch from Supabase
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _posts = [
          Post(
            id: '1',
            userId: 'user1',
            content: 'Just read an amazing new chapter! What did you guys think?',
            images: ['https://example.com/post1.jpg'],
            likes: 24,
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
            updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          Post(
            id: '2',
            userId: 'user2',
            content: 'Recommend me some good manhwa to read! 🎯',
            images: [],
            likes: 15,
            createdAt: DateTime.now().subtract(const Duration(hours: 5)),
            updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
          ),
        ];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Community', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePostScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPosts,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return _PostCard(post: post);
                },
              ),
            ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12151B),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User123', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('2 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
            
            // Post Content
            Text(post.content, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 12),
            
            // Post Images
            if (post.images.isNotEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(post.images.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            
            // Like & Comment Buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: () {},
                ),
                Text('${post.likes}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(postId: post.id),
                      ),
                    );
                  },
                ),
                const Text('12', style: TextStyle(color: Colors.grey)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.grey),
                  onPressed: () {},
                  // Di dalam _PostCard  widget, update onTap:
                  onTap: () {
                   Navigator.push(
                   context,
                   MaterialPageRoute(
                   builder: (context) => PostDetailScreen(postId: post.id),
                     ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}