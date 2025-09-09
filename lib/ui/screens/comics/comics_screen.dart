import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../providers/comic_provider.dart';
import '../../providers/ads_provider.dart';
import '../../widgets/comic_card.dart';
import '../../widgets/ad_banner.dart';
import 'comic_detail_screen.dart';

class ComicsScreen extends StatefulWidget {
  const ComicsScreen({super.key});

  @override
  State<ComicsScreen> createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ComicProvider>(context, listen: false).loadComics();
      Provider.of<AdsProvider>(context, listen: false).showInterstitialAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    final comicProvider = Provider.of<ComicProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Comics', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Comics Grid
          Expanded(
            child: comicProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : comicProvider.comics.isEmpty
                    ? const Center(
                        child: Text(
                          'No comics available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: comicProvider.comics.length,
                        itemBuilder: (context, index) {
                          final comic = comicProvider.comics[index];
                          return ComicCard(
                            comic: comic,
                            onTap: () {
                              Provider.of<AdsProvider>(context, listen: false).showInterstitialAd();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComicDetailScreen(comicId: comic.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
          
          // Ad Banner
          const AdBannerWidget(),
        ],
      ),
    );
  }
}