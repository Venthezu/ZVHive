import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';
import '../models/post_model.dart';

class PostService {
  final SupabaseClient client = SupabaseClient.instance;

  Future<List<Post>> getPosts() async {
    final response = await client.database
        .from('posts')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> getPostById(String id) async {
    final response = await client.database
        .from('posts')
        .select()
        .eq('id', id)
        .single();

    return Post.fromJson(response);
  }

  Future<void> createPost(Post post) async {
    await client.database
        .from('posts')
        .insert(post.toJson());
  }

  Future<void> updatePost(String id, Map<String, dynamic> updates) async {
    await client.database
        .from('posts')
        .update(updates)
        .eq('id', id);
  }

  Future<void> deletePost(String id) async {
    await client.database
        .from('posts')
        .delete()
        .eq('id', id);
  }

  Future<void> likePost(String postId, String userId) async {
    await client.database
        .from('likes')
        .insert({'post_id': postId, 'user_id': userId});
  }

  Future<void> unlikePost(String postId, String userId) async {
    await client.database
        .from('likes')
        .delete()
        .eq('post_id', postId)
        .eq('user_id', userId);
  }
}