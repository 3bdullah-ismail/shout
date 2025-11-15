import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:news/presentation/layout/data/models/source_model/sources.dart';

import '../../data/models/articles.dart';
import '../../data/repositories/repo.dart';

part 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.newsRepo}) : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsRepo newsRepo;
  Future<void> getNews({Source? source}) async {
    emit(GetNewsLoadingState());
    try {
      var result = await newsRepo.getNews(source!);
      if (result.isRight) {
        emit(GetNewsSuccessState(articles: result.right));
      } else {
        emit(GetNewsErrorState(massage: result.left.message ?? ''));
      }
    } catch (e) {
      emit(GetNewsErrorState(massage: e.toString()));
    }
  }
}
