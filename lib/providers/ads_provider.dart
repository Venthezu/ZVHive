import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../core/env.dart';

class AdsProvider with ChangeNotifier {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isBannerLoaded = false;
  bool _isInterstitialLoaded = false;

  BannerAd? get bannerAd => _bannerAd;
  bool get isBannerLoaded => _isBannerLoaded;
  bool get isInterstitialLoaded => _isInterstitialLoaded;

  // Initialize Mobile Ads
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  // Load Banner Ad
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Env.admobBannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isBannerLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _isBannerLoaded = false;
          notifyListeners();
        },
      ),
    );
    _bannerAd?.load();
  }

  // Load Interstitial Ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Env.admobInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isInterstitialLoaded = false;
          notifyListeners();
        },
      ),
    );
  }

  // Show Interstitial Ad
  Future<void> showInterstitialAd() async {
    if (_isInterstitialLoaded) {
      _interstitialAd?.show();
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _loadInterstitialAd();
        },
      );
    }
  }

  // Dispose ads
  void disposeAds() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}