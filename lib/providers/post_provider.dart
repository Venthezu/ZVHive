import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPosts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _posts = await _postService.getPosts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load posts';
      notifyListeners();
    }
  }

  Future<void> createPost(String content, List<String> images) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Create post logic here
      await _postService.createPost(Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user_id', // Get from auth
        content: content,
        images: images,
        likes: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      await loadPosts(); // Reload posts
    } catch (e) {
      _error = 'Failed to create post';
      notifyListeners();
    }
  }

  Future<void> likePost(String postId) async {
    try {
      await _postService.likePost(postId, 'current_user_id');
      // Update local post likes count
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        _posts[postIndex] = Post(
          id: _posts[postIndex].id,
          userId: _posts[postIndex].userId,
          content: _posts[postIndex].content,
          images: _posts[postIndex].images,
          likes: _posts[postIndex].likes + 1,
          createdAt: _posts[postIndex].createdAt,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to like post';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}