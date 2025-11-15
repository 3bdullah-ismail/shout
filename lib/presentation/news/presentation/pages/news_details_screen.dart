import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/custom_btn.dart';
import 'package:news/main.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/assets/app_assets_path.dart';
import '../../../layout/presentation/manager/main_provider.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    var provider = context.read<MainProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppAssetsPath.shareIcon),
            onPressed: () => _onShareUri(context, article.url ?? ""),
          ),
          Consumer<MainProvider>(
            builder: (context, value, child) {
              bool isBookMarked = value.isSaved(article);
              return IconButton(
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
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(child: CircularProgressIndicator());
                    },
                    height: 200.h,
                    width: 336.w,
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(article.title ?? "", style: context.textTheme.bodyLarge),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "By: ${article.author ?? ""}",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.grayPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    provider.formatDate(article.publishedAt ?? ""),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(article.description ?? ""),

              const Spacer(),
              CustomBtn(
                isLoading: false,
                onPressed: () async {
                  await _launchUrl(Uri.parse(article.url ?? ""));
                },
                text: "View Full Article",
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onShareUri(BuildContext context, String urlString) async {
    try {
      if (urlString.isEmpty) {
        return;
      }
      final Uri uri = Uri.parse(urlString);
      final params = ShareParams(uri: uri);
      await SharePlus.instance.share(params);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
