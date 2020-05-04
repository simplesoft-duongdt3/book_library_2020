import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:booklibrary2020/data/cache/book_cache_manager.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'bloc.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final BookRepository _bookRepository;
  BookListBloc(this._bookRepository);

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
    var books = await _bookRepository.getBooks(FilterBook(isGetNewestBooks: categoryId <= 0, categoryId: categoryId, searchTerm: searchTerm));
    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }

  Stream<BookListState> handleGetItemsEvent(int categoryId) async* {
    yield LoadingBookListState();
    var books = await _bookRepository.getBooks(FilterBook(isGetNewestBooks: categoryId <= 0, categoryId: categoryId));

    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }
}
