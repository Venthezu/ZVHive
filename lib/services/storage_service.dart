import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';

class StorageService {
  final SupabaseClient client = SupabaseClient.instance;

  Future<String> uploadAvatar(String userId, String filePath) async {
    final String fileName = 'avatar_$userId${DateTime.now().millisecondsSinceEpoch}';
    
    final response = await client.storage
        .from('avatars')
        .upload(fileName, filePath);

    return client.storage.from('avatars').getPublicUrl(response);
  }

  Future<String> uploadPostImage(String postId, String filePath) async {
    final String fileName = 'post_$postId${DateTime.now().millisecondsSinceEpoch}';
    
    final response = await client.storage
        .from('posts')
        .upload(fileName, filePath);

    return client.storage.from('posts').getPublicUrl(response);
  }

  Future<String> uploadComicCover(String comicId, String filePath) async {
    final String fileName = 'cover_$comicId${DateTime.now().millisecondsSinceEpoch}';
    
    final response = await client.storage
        .from('covers')
        .upload(fileName, filePath);

    return client.storage.from('covers').getPublicUrl(response);
  }

  Future<void> deleteFile(String bucket, String fileName) async {
    await client.storage
        .from(bucket)
        .remove([fileName]);
  }

  Future<List<String>> listFiles(String bucket, String path) async {
    final response = await client.storage
        .from(bucket)
        .list(path: path);

    return response.map((file) => file.name).toList();
  }
}