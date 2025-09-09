import '../services/api_service.dart';
import '../models/download_model.dart';

class DownloadService {
  final ApiService _apiService = ApiService();

  Future<DownloadResult> downloadYouTube(String url) async {
    final response = await _apiService.post('youtube/download', {
      'url': url,
    });
    return DownloadResult.fromJson(response);
  }

  Future<DownloadResult> downloadTikTok(String url) async {
    final response = await _apiService.post('tiktok/download', {
      'url': url,
    });
    return DownloadResult.fromJson(response);
  }

  Future<DownloadResult> downloadInstagram(String url) async {
    final response = await _apiService.post('instagram/download', {
      'url': url,
    });
    return DownloadResult.fromJson(response);
  }

  Future<DownloadResult> downloadOther(String url) async {
    final response = await _apiService.post('other/download', {
      'url': url,
    });
    return DownloadResult.fromJson(response);
  }
}