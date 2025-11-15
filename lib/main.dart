import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news.dart';

import 'package:news/presentation/layout/presentation/manager/main_cubit.dart';
import 'package:news/presentation/layout/presentation/manager/main_provider.dart';
import 'package:news/presentation/news/presentation/manager/news_cubit.dart';
import 'package:provider/provider.dart';

import 'core/config/get_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MainCubit>()),
        BlocProvider(create: (context) => getIt<NewsCubit>()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: const News(),
    ),
  );
}

extension BuildContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
}
