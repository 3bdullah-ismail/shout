import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/models/category_model.dart';
import 'package:news/core/routes/app_route_names.dart';
import 'package:news/main.dart';

import '../../../../core/theme/app_colors.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categories", style: context.textTheme.bodyLarge),
                  SizedBox(height: 8.h),
                  Text(
                    "Thousands of articles in each category",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: REdgeInsets.all(16.r),
                itemCount: CategoryModel.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final category = CategoryModel.categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouteNames.source,
                        arguments: category,
                      );
                    },
                    child: Container(
                      padding: REdgeInsets.symmetric(
                        horizontal: 12.r,
                        vertical: 16.r,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
