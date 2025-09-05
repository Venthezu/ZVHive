import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get admobAppId => dotenv.env['ADMOB_APP_ID'] ?? '';
  static String get admobBannerId => dotenv.env['ADMOB_BANNER_ID'] ?? '';
  static String get admobInterstitialId => dotenv.env['ADMOB_INTERSTITIAL_ID'] ?? '';
  static String get downloaderApiBaseUrl => dotenv.env['DOWNLOADER_API_BASE_URL'] ?? 'https://api.vreden.my.id';
}