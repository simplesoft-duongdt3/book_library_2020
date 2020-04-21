import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import './bloc.dart';

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
      yield* handleGetItemsEvent();
    }
  }

  Stream<BookListState> handleGetItemsEvent() async* {
    yield LoadingBookListState();
    NetworkResponseModel<List<BookEntity>> books = await _bookRepository.getBooks();

    if (books.isSuccess()) {
      yield SuccessBookListState(books.responseModel);
    } else {
      yield ErrorBookListState();
    }
  }
}