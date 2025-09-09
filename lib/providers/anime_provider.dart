import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/anime_service.dart';

class AnimeProvider with ChangeNotifier {
  final AnimeService _animeService = AnimeService();
  List<Anime> _animeList = [];
  bool _isLoading = false;
  String? _error;

  List<Anime> get animeList => _animeList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAnimeList() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _animeList = await _animeService.getAnimeList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load anime list';
      notifyListeners();
    }
  }

  Future<Anime> getAnime(String id) async {
    return await _animeService.getAnimeById(id);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}