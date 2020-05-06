import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:booklibrary2020/common/common.dart';
import 'package:booklibrary2020/data/cache/book_cache_manager.dart';
import 'package:booklibrary2020/data/models/category.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/features/main/category_list/category_list.dart';
import './bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final BookRepository _bookRepository;
  CategoryBloc(this._bookRepository);

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategoryItemsEvent) {
      yield* handleGetCategoryItemsEvent();
    }
  }

  Stream<CategoryState> handleGetCategoryItemsEvent() async* {
    yield LoadingCategoryListState();
    var categories = await _bookRepository.getCategoryBookItems();

    if (categories.isSuccess()) {
      yield SuccessCategoryListState(categories.responseModel);
    } else {
      yield ErrorLoadingCategoryListState();
    }
  }
}
