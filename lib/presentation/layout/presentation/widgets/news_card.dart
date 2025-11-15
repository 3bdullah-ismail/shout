import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/main.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets/app_assets_path.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../manager/main_provider.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    var provider = context.read<MainProvider>();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouteNames.newsDetails,
          arguments: article,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  height: 220,
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article.title ?? "",
                      style: context.textTheme.titleSmall!.copyWith(
                        color: AppColors.black,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),

                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      bool isBookMarked = value.isSaved(article);

                      return Padding(
                        padding: REdgeInsets.only(top: 4.0),
                        child: IconButton(
                          onPressed: () {
                            isBookMarked
                                ? value.removeArticle(article)
                                : value.addArticle(article);
                          },
                          icon: SvgPicture.asset(
                            isBookMarked
                                ? AppAssetsPath.bookSelectedIcon
                                : AppAssetsPath.bookUnselectedIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: REdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "By: ${article.author ?? ""}",
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    provider.formatDate(article.publishedAt ?? ''),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
