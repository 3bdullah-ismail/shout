part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class GetNewsSuccessState extends NewsState {
  final List<Article> articles;
  GetNewsSuccessState({required this.articles});
}

final class GetNewsLoadingState extends NewsState {}

final class GetNewsErrorState extends NewsState {
  final String massage;
  GetNewsErrorState({required this.massage});
}
