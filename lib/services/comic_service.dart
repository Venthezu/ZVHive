import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';
import '../models/comic_model.dart';

class ComicService {
  final SupabaseClient client = SupabaseClient.instance;

  Future<List<Comic>> getComics() async {
    final response = await client.database
        .from('comics')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => Comic.fromJson(json)).toList();
  }

  Future<Comic> getComicById(String id) async {
    final response = await client.database
        .from('comics')
        .select()
        .eq('id', id)
        .single();

    return Comic.fromJson(response);
  }

  Future<void> addComic(Comic comic) async {
    await client.database
        .from('comics')
        .insert(comic.toJson());
  }

  Future<void> updateComic(String id, Map<String, dynamic> updates) async {
    await client.database
        .from('comics')
        .update(updates)
        .eq('id', id);
  }
}