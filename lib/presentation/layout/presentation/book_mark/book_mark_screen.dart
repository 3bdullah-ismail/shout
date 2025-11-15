import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/assets/app_assets_path.dart';
import 'package:provider/provider.dart';
import 'package:news/main.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/book_mark_card.dart';
import '../../presentation/manager/main_provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bookmarks", style: context.textTheme.bodyLarge),
                  SizedBox(height: 8.h),
                  Text(
                    "Saved articles to the library",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<MainProvider>(
                builder: (context, provider, child) {
                  if (provider.savedArticles.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssetsPath.bookMarkImage),
                          SizedBox(height: 16.h),
                          Text(
                            "You haven't saved any articles \nyet. Start reading and\n bookmarking them now",
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: REdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: provider.savedArticles.length,
                    itemBuilder: (context, index) {
                      return BookMarkCard(
                        article: provider.savedArticles[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
