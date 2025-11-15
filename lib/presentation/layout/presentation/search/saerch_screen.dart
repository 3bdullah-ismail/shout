import 'package:flutter/material.dart';

import '../../../news/data/models/articles.dart';
import 'custom_search_delegate.dart';

class SearchScreen extends StatelessWidget {
  final List<Article> articles;

  const SearchScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchList: articles),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text("Click search to start")),
    );
  }
}
