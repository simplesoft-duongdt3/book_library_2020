import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:booklibrary2020/common/common.dart';
import 'package:booklibrary2020/data/cache/book_cache_manager.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'bloc.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final BookRepository _bookRepository;
  BookListBloc(this._bookRepository);

  final Random _random = Random();

  @override
  BookListState get initialState => InitialBookListState();

  @override
  Stream<BookListState> mapEventToState(
    BookListEvent event,
  ) async* {
    if (event is GetItemsEvent) {
      yield* handleGetItemsEvent(event.categoryId);
    } else if (event is SearchItemsEvent) {
      yield* handleSearchItemsEvent(event.categoryId, event.searchTerm);
    }
  }

  Stream<BookListState> handleSearchItemsEvent(int categoryId, String searchTerm) async* {
    var books = await _bookRepository.getBooks(FilterBook(isGetAllCategory: false, categoryId: categoryId, searchTerm: searchTerm));
    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }

  Stream<BookListState> handleGetItemsEvent(int categoryId) async* {
    yield LoadingBookListState();
    var books = await _bookRepository.getBooks(FilterBook(isGetAllCategory: false, categoryId: categoryId));

    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }
}
