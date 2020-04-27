import 'package:meta/meta.dart';
import 'package:booklibrary2020/data/models/book.dart';

@immutable
abstract class BookListState {}

class InitialBookListState extends BookListState {}

class LoadingBookListState extends BookListState {}

class ErrorBookListState extends BookListState {}

class SuccessBookListState extends BookListState {
  final List<BookEntity> listBook;

  SuccessBookListState(this.listBook);
}