import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news/core/assets/app_assets_path.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/main.dart';

import 'package:news/presentation/onboarding/presentation/widgets/onboarding_card.dart';

import '../../../../core/routes/app_route_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;
  List<String> images = [
    AppAssetsPath.onboarding1Image,
    AppAssetsPath.onboarding2Image,
    AppAssetsPath.onboarding3Image,
  ];

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 24.w;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 336.h,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,

                    autoPlayInterval: const Duration(milliseconds: 400),
                    viewportFraction: 0.7,
                    onPageChanged: (i, reason) {
                      setState(() {
                        index = i;
                      });
                    },
                  ),
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 250.w,
                          margin: REdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(i, fit: BoxFit.cover),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...[0, 1, 2].map((e) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: e == index
                              ? AppColors.purplePrimary
                              : AppColors.gray,
                        ),
                        margin: const EdgeInsets.all(4),
                        width: e == index ? 30 : 10,
                      );
                    }),
                  ],
                ),

                SizedBox(height: 24.h),

                Text("First to know", style: context.textTheme.bodyMedium),
              ],
            ),

            const Spacer(),

            Padding(
              padding: REdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 24.h,
              ),
              child: OnboardingCard(
                text: "Next",
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteNames.welcome);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
