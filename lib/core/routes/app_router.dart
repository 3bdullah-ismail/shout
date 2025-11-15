// lib/core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:news/core/models/category_model.dart';
import 'package:news/core/routes/app_route_names.dart';
import 'package:news/presentation/layout/presentation/main_layout_screen.dart';
import 'package:news/presentation/news/data/models/articles.dart';
import 'package:news/presentation/news/presentation/pages/news_details_screen.dart';
import 'package:news/presentation/news/presentation/pages/news_screen.dart';
import 'package:news/presentation/news/presentation/pages/source_screen.dart';
import 'package:news/presentation/onboarding/presentation/pages/welcome_screen.dart';

import '../../presentation/layout/data/models/source_model/sources.dart';
import '../../presentation/layout/presentation/home/presentation/home_screen.dart';
import '../../presentation/onboarding/presentation/pages/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRouteNames.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRouteNames.layout:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      case AppRouteNames.source:
        final CategoryModel args = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => SourceScreen(categoryModel: args),
        );
      case AppRouteNames.news:
        final Source source = settings.arguments as Source;
        return MaterialPageRoute(builder: (_) => NewsScreen(source: source));
      case AppRouteNames.newsDetails:
        final Article article = settings.arguments as Article;
        return MaterialPageRoute(
          builder: (_) => NewsDetailsScreen(article: article),
        );
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("404 - Page not found"))),
        );
    }
  }
}
