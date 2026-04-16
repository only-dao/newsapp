import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];
  final List<Article> _favorites = [];

  bool isLoading = false;
  String error = '';

  List<Article> get articles => _articles;
  List<Article> get favorites => _favorites;

  Future<void> fetchArticles() async {
    try {
      isLoading = true;
      notifyListeners();

      _articles = await ApiService.fetchArticles();
      error = '';
    } catch (e) {
      error = 'Lỗi tải dữ liệu';
    }

    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(Article article) {
    if (_favorites.contains(article)) {
      _favorites.remove(article);
    } else {
      _favorites.add(article);
    }
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favorites.contains(article);
  }

  List<Article> search(String keyword) {
    return _articles
        .where((a) =>
        a.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}