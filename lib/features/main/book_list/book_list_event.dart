import 'package:meta/meta.dart';

@immutable
abstract class BookListEvent {}

class GetItemsEvent extends BookListEvent {}

class SearchItemsEvent extends BookListEvent {}
