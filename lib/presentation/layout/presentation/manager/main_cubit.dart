import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/category_model.dart';
import '../../data/models/source_model/sources.dart';
import '../../data/repositories/repo.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit({required this.mainRepo})
    : currentCategory = CategoryModel.categories.first,
      super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  MainRepo mainRepo;
  int selectedIndex = 0;
  CategoryModel currentCategory;

  void changeSelectedIndex(int newIndex) {
    if (selectedIndex != newIndex) {
      selectedIndex = newIndex;
      changeCategory();
      getSources(category: currentCategory.categoryName);

      emit(ChangeCategoryState());
    }
  }

  void changeCategory() {
    currentCategory = CategoryModel.categories[selectedIndex];
  }

  List<Source> sources = [];

  Future<void> getSources({required String category}) async {
    emit(GetSourceLoading());
    try {
      var result = await mainRepo.getSources(category: category);
      if (result.isRight) {
        sources = result.right;
        emit(GetSourceSuccess(sources: result.right));
      } else {
        emit(GetSourceError(massage: result.left.message ?? ""));
      }
    } catch (e) {
      emit(GetSourceError(massage: e.toString()));
    }
  }
}
