import 'package:supabase_flutter/supabase_flutter.dart';
import 'env.dart';

class SupabaseClient {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
  }

  static SupabaseClient get instance => Supabase.instance;
  static GoTrueClient get auth => Supabase.instance.client.auth;
  static Postgrest get database => Supabase.instance.client;
  static Realtime get realtime => Supabase.instance.client.realtime;
  static Storage get storage => Supabase.instance.client.storage;
}