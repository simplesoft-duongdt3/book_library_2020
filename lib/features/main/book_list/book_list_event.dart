import 'package:meta/meta.dart';

@immutable
abstract class BookListEvent {}

class GetItemsEvent extends BookListEvent {
  final int categoryId;
  GetItemsEvent(this.categoryId);
}

class SearchItemsEvent extends BookListEvent {
  final int categoryId;
  final String searchTerm;

  SearchItemsEvent(this.categoryId, this.searchTerm);
}
