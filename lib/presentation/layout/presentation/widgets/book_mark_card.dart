import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/main.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../news/data/models/articles.dart';

class BookMarkCard extends StatelessWidget {
  const BookMarkCard({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouteNames.newsDetails,
          arguments: article,
        );
      },
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  height: 96.h,
                  width: 96.w,
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.source!.name ?? "",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      article.title ?? "",
                      style: context.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
