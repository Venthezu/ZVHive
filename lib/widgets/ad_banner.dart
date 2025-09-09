import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../providers/ads_provider.dart';

class AdBannerWidget extends StatefulWidget {
  final AdSize? adSize;

  const AdBannerWidget({super.key, this.adSize});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);

    if (!adsProvider.isBannerLoaded || adsProvider.bannerAd == null) {
      return Container(
        height: widget.adSize?.height.toDouble() ?? 50,
        color: const Color(0xFF12151B),
        child: const Center(
          child: Text(
            'Loading Ad...',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: widget.adSize?.height.toDouble() ?? 50,
      alignment: Alignment.center,
      child: AdWidget(ad: adsProvider.bannerAd!),
    );
  }
}