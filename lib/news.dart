import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/routes/app_router.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/main.dart';

import 'core/routes/app_route_names.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width, context.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "news",
        theme: AppTheme.appTheme,
        initialRoute: AppRouteNames.onboarding,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
