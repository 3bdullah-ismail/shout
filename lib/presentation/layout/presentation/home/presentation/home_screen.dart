import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/models/category_model.dart';
import 'package:news/main.dart';
import 'package:news/presentation/layout/presentation/manager/main_cubit.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/tab_widget.dart';
import '../../../../news/presentation/manager/news_cubit.dart';
import '../../search/custom_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = MainCubit.get(context);
    cubit.getSources(category: cubit.currentCategory.categoryName);
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: REdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Browse", style: context.textTheme.bodyLarge),
                      SizedBox(height: 8.h),
                      Text(
                        "Discover things of this world",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.grayPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<NewsCubit, NewsState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (state is GetNewsSuccessState) {
                          final List<Article> articles = state.articles;

                          if (articles.isNotEmpty) {
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                searchList: articles,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please wait, loading articles...",
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please wait, loading articles..."),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),
            DefaultTabController(
              length: CategoryModel.categories.length,
              child: TabBar(
                onTap: (value) {
                  final cubit = MainCubit.get(context);
                  cubit.changeSelectedIndex(value);
                  selectedIndex = value;
                  setState(() {});
                },
                indicatorPadding: EdgeInsets.zero,
                labelPadding: REdgeInsets.symmetric(horizontal: 8.0),
                indicator: const BoxDecoration(),
                isScrollable: true,
                tabs: CategoryModel.categories.map((category) {
                  final index = CategoryModel.categories.indexOf(category);
                  return TabWidget(
                    label: CategoryModel.categories[index].title,
                    isSelected: index == selectedIndex,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                if (state is GetSourceSuccess) {
                  return Expanded(
                    child: Padding(
                      padding: REdgeInsets.all(16.0),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouteNames.news,
                                arguments: state.sources[index],
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Padding(
                                padding: REdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.sources[index].name ?? "",
                                      style: context.textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      state.sources[index].description ?? "",
                                      style: context.textTheme.bodySmall,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemCount: state.sources.length,
                      ),
                    ),
                  );
                } else if (state is GetSourceError) {
                  return Expanded(child: Center(child: Text(state.massage)));
                } else if (state is GetSourceLoading) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox();
              },
              buildWhen: (previous, current) {
                return current is GetSourceSuccess ||
                    current is GetSourceError ||
                    current is GetSourceLoading;
              },
            ),
          ],
        ),
      ),
    );
  }
}
