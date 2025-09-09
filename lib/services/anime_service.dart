import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';
import '../models/anime_model.dart';

class AnimeService {
  final SupabaseClient client = SupabaseClient.instance;

  Future<List<Anime>> getAnimeList() async {
    final response = await client.database
        .from('anime')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => Anime.fromJson(json)).toList();
  }

  Future<Anime> getAnimeById(String id) async {
    final response = await client.database
        .from('anime')
        .select()
        .eq('id', id)
        .single();

    return Anime.fromJson(response);
  }

  Future<List<Anime>> getAnimeByType(String type) async {
    final response = await client.database
        .from('anime')
        .select()
        .eq('type', type)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Anime.fromJson(json)).toList();
  }

  Future<void> addAnime(Anime anime) async {
    await client.database
        .from('anime')
        .insert(anime.toJson());
  }

  Future<void> updateAnime(String id, Map<String, dynamic> updates) async {
    await client.database
        .from('anime')
        .update(updates)
        .eq('id', id);
  }
}