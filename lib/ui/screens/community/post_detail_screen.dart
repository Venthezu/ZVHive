import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../providers/post_provider.dart';
import '../../../models/post_model.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = true;
  Post? _post;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    try {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      // In real app, fetch from provider
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _post = Post(
          id: widget.postId,
          userId: 'user123',
          content: 'This is a sample post content for demonstration. What do you think about this new chapter?',
          images: ['https://example.com/post-image.jpg'],
          likes: 42,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _likePost() {
    // Like post logic
    setState(() {
      _post = Post(
        id: _post!.id,
        userId: _post!.userId,
        content: _post!.content,
        images: _post!.images,
        likes: _post!.likes + 1,
        createdAt: _post!.createdAt,
        updatedAt: DateTime.now(),
      );
    });
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    // Add comment logic
    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Post', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _post == null
              ? const Center(child: Text('Post not found', style: TextStyle(color: Colors.grey)))
              : Column(
                  children: [
                    // Post Content
                    Expanded(
                      child: SingleChildScrollView(
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
                                      Text('3 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Post Content
                            Text(
                              _post!.content,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 16),

                            // Post Images
                            if (_post!.images.isNotEmpty)
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(_post!.images.first),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),

                            // Like Count
                            Text(
                              '${_post!.likes} likes',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Actions
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: _post!.likes > 0 ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: _likePost,
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.comment, color: Colors.grey),
                                const SizedBox(width: 8),
                                const Icon(Icons.share, color: Colors.grey),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Comments Section
                            const Text(
                              'Comments',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Sample Comments
                            _buildComment(
                              'Alice',
                              'Great post! I totally agree with you.',
                              '2 hours ago',
                            ),
                            _buildComment(
                              'Bob',
                              'This chapter was amazing! The art is getting better.',
                              '1 hour ago',
                            ),
                            _buildComment(
                              'Charlie',
                              'Can\'t wait for the next update!',
                              '30 minutes ago',
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Comment Input
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xFF12151B),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage('https://example.com/user-avatar.jpg'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1A1F2E),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send, color: Color(0xFF6D28D9)),
                            onPressed: _addComment,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildComment(String username, String comment, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://example.com/comment-avatar.jpg'),
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
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}