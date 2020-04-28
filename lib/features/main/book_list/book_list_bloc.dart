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
      yield* handleGetItemsEvent();
    } else if (event is SearchItemsEvent) {
      yield* handleSearchItemsEvent();
    }
  }

  Stream<BookListState> handleSearchItemsEvent() async* {
    NetworkResponseModel<List<BookEntity>> books = await _bookRepository.getBooks(FilterBook(isGetAllCategory: false, categoryId: _random.nextInt(6), searchTerm: "a"));
    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }

  Stream<BookListState> handleGetItemsEvent() async* {
    yield LoadingBookListState();
    NetworkResponseModel<List<BookEntity>> books = await _bookRepository.getBooks(FilterBook(isGetAllCategory: false, categoryId: _random.nextInt(6)));

    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }
}
