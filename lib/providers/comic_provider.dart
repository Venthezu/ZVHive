import 'package:flutter/material.dart';
import '../models/comic_model.dart';
import '../services/comic_service.dart';

class ComicProvider with ChangeNotifier {
  final ComicService _comicService = ComicService();
  List<Comic> _comics = [];
  bool _isLoading = false;
  String? _error;

  List<Comic> get comics => _comics;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadComics() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _comics = await _comicService.getComics();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load comics';
      notifyListeners();
    }
  }

  Future<Comic> getComic(String id) async {
    return await _comicService.getComicById(id);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}