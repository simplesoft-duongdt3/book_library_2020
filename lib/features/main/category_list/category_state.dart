import 'package:booklibrary2020/data/models/category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class LoadingCategoryListState extends CategoryState { }

class SuccessCategoryListState extends CategoryState {
  final List<CategoryEntity> listCategory;

  SuccessCategoryListState(this.listCategory);
}

class ErrorLoadingCategoryListState extends CategoryState { }