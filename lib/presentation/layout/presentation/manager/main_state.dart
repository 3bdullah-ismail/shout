part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class GetSourceLoading extends MainState {}

final class GetSourceSuccess extends MainState {
  final List<Source> sources;
  GetSourceSuccess({required this.sources});
}

final class GetSourceError extends MainState {
  final String massage;
  GetSourceError({required this.massage});
}

class ChangeCategoryState extends MainState {}
