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
      yield* handleGetItemsEvent(event.categoryId, null);
    } else if (event is SearchItemsEvent) {
      yield* handleGetItemsEvent(event.categoryId, event.searchTerm);
    }
  }

  Stream<BookListState> handleGetItemsEvent(int categoryId, String searchTerm) async* {
    GetBookRequest filterBookRequest = GetAllGetBookRequest();
    if ((categoryId != null && categoryId > 0) || (searchTerm != null && searchTerm.isNotEmpty)) {
      filterBookRequest = SearchGetBookRequest(categoryId: categoryId, searchTerm: searchTerm);
    }
    var books = await _bookRepository.getBooks(filterBookRequest);
    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }
}
