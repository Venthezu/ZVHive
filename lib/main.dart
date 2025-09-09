import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/supabase_client.dart';
import 'core/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/comic_provider.dart';
import 'providers/anime_provider.dart';
import 'providers/download_provider.dart';
import 'providers/ads_provider.dart';
import 'providers/post_provider.dart';
import 'providers/chat_provider.dart';
import 'ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: '.env');
  await SupabaseClient.initialize();
  MobileAds.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ComicProvider()),
        ChangeNotifierProvider(create: (_) => AnimeProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'ZVHive',
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}