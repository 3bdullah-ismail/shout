import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../news/data/models/articles.dart';
import '../widgets/news_card.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Article> searchList;

  CustomSearchDelegate({required this.searchList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Article> searchResults = searchList
        .where(
          (item) =>
              (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (item.description?.toLowerCase().contains(query.toLowerCase()) ??
                  false),
        )
        .toList();

    if (searchResults.isEmpty) {
      return const Center(child: Text("No results found"));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return NewsCard(article: searchResults[index]);
        },
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: searchResults.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Article> suggestions = query.isEmpty
        ? []
        : searchList
              .where(
                (item) =>
                    (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                    false),
              )
              .toList();

    if (suggestions.isEmpty) {
      return const Center(child: Text("No suggestions found"));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return NewsCard(article: suggestions[index]);
        },
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: suggestions.length,
      ),
    );
  }
}
