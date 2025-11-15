import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/presentation/layout/data/models/source_model/sources.dart';

import '../../../layout/presentation/widgets/news_card.dart';
import '../manager/news_cubit.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({required this.source, super.key});

  final Source source;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = NewsCubit.get(context);

    cubit.getNews(source: widget.source);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.source.name ?? "")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                buildWhen: (previous, current) {
                  return current is GetNewsSuccessState ||
                      current is GetNewsErrorState ||
                      current is GetNewsLoadingState;
                },
                builder: (context, state) {
                  if (state is GetNewsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetNewsSuccessState) {
                    if (state.articles.isEmpty) {
                      return const Center(
                        child: Text(
                          "There is currently no news for this source.",
                        ),
                      );
                    }
                    return Padding(
                      padding: REdgeInsets.all(16.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return NewsCard(article: state.articles[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },

                        itemCount: state.articles.length,
                      ),
                    );
                  } else if (state is GetNewsErrorState) {
                    return Center(child: Text(state.massage));
                  }

                  return const Center(child: Text("Select a source"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
