import 'package:flutter/material.dart';
import 'package:news/presentation/news/data/models/articles.dart';

class MainProvider extends ChangeNotifier {
  List<Article> savedArticles = [];

  void addArticle(Article article) {
    savedArticles.add(article);
    notifyListeners();
  }

  void removeArticle(Article article) {
    savedArticles.remove(article);
    notifyListeners();
  }

  bool isSaved(Article article) {
    return savedArticles.contains(article);
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    bool isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    if (isToday) {
      return "${date.hour.toString().padLeft(2, '0')}:"
          "${date.minute.toString().padLeft(2, '0')}";
    } else {
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    }
  }
}
