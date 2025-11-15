import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/models/category_model.dart';
import 'package:news/main.dart';
import 'package:news/presentation/news/presentation/manager/news_cubit.dart';

import '../../../layout/presentation/widgets/news_card.dart';
import '../../../layout/presentation/manager/main_cubit.dart';
import '../../../../core/widgets/tab_widget.dart';

// ignore: must_be_immutable
class SourceScreen extends StatefulWidget {
  SourceScreen({super.key, required this.categoryModel});

  CategoryModel categoryModel;

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  int selectedIndex = 0;
  // New variable to track source loading
  bool _sourcesLoadedSuccessfully = false;

  @override
  void initState() {
    super.initState();
    final cubit = MainCubit.get(context);
    cubit.getSources(category: widget.categoryModel.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryModel.title)),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<MainCubit, MainState>(
              listenWhen: (previous, current) => current is GetSourceSuccess,
              listener: (context, state) {
                if (state is GetSourceSuccess) {
                  // Set the flag to true on success
                  setState(() {
                    _sourcesLoadedSuccessfully = true;
                  });

                  if (state.sources.isNotEmpty) {
                    context.read<NewsCubit>().getNews(source: state.sources[0]);
                  }
                }
              },
              // ... buildWhen is fine as is
              buildWhen: (previous, current) {
                return current is GetSourceSuccess ||
                    current is GetSourceError ||
                    current is GetSourceLoading;
              },
              builder: (context, state) {
                if (state is GetSourceLoading) {
                  return SizedBox(
                    height: 50.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is GetSourceError) {
                  return SizedBox(
                    height: 50.h,
                    child: Center(child: Text(state.massage)),
                  );
                } else if (state is GetSourceSuccess) {
                  return SizedBox(
                    height: 50.h,
                    child: DefaultTabController(
                      length: state.sources.length,
                      child: TabBar(
                        onTap: (value) {
                          setState(() {
                            selectedIndex = value;
                          });

                          context.read<NewsCubit>().getNews(
                            source: state.sources[value],
                          );
                        },
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: REdgeInsets.symmetric(horizontal: 8.0),
                        indicator: const BoxDecoration(),
                        isScrollable: true,
                        tabs: state.sources.map((source) {
                          final index = state.sources.indexOf(source);
                          return TabWidget(
                            label: source.name ?? "",
                            isSelected: index == selectedIndex,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

            // Use the flag to conditionally render the news section
            _sourcesLoadedSuccessfully
                ? Expanded(
                    child: BlocBuilder<NewsCubit, NewsState>(
                      buildWhen: (previous, current) {
                        return current is GetNewsSuccessState ||
                            current is GetNewsErrorState ||
                            current is GetNewsLoadingState;
                      },
                      builder: (context, state) {
                        if (state is GetNewsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetNewsSuccessState) {
                          if (state.articles.isEmpty) {
                            return Center(
                              child: Text(
                                "There is no news available from \nthis source at this time.",
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.center,
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
                        // Only show this initial message if sources are loaded but news hasn't fetched yet/has no state.
                        return const Center(child: Text("Select a source"));
                      },
                    ),
                  )
                : const Expanded(
                    // Placeholder for the news area while sources are loading
                    child: Center(child: Text("Waiting for news sources...")),
                  ),
          ],
        ),
      ),
    );
  }
}
