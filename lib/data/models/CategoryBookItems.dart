import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/models/category.dart';
import 'package:flutter/foundation.dart';

@immutable
class CategoryBookItemsEntity {
  final CategoryEntity category;
  final List<BookEntity> books;

  CategoryBookItemsEntity({this.category, this.books});
}
