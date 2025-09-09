import 'package:flutter/material.dart';
import '../models/download_model.dart';
import '../services/download_service.dart';

class DownloadProvider with ChangeNotifier {
  final DownloadService _downloadService = DownloadService();
  DownloadResult? _downloadResult;
  bool _isLoading = false;
  String? _error;

  DownloadResult? get downloadResult => _downloadResult;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> downloadYouTube(String url) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _downloadResult = await _downloadService.downloadYouTube(url);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to download from YouTube';
      notifyListeners();
    }
  }

  Future<void> downloadTikTok(String url) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _downloadResult = await _downloadService.downloadTikTok(url);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to download from TikTok';
      notifyListeners();
    }
  }

  Future<void> downloadInstagram(String url) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _downloadResult = await _downloadService.downloadInstagram(url);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to download from Instagram';
      notifyListeners();
    }
  }

  void clearResult() {
    _downloadResult = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}