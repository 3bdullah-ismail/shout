import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/main.dart';

import 'package:news/presentation/onboarding/presentation/widgets/onboarding_card.dart';

import '../../../../core/assets/app_assets_path.dart';
import '../../../../core/routes/app_route_names.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 24.w;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),

            Image.asset(
              AppAssetsPath.onboarding4Image,
              fit: BoxFit.cover,
              width: context.width,
              height: 400.h,
            ),

            const Spacer(),

            Padding(
              padding: REdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 32.h,
              ),

              child: OnboardingCard(
                text: "Get Started",
                onPressed: () {
                  Navigator.pushNamed(context, AppRouteNames.layout);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
