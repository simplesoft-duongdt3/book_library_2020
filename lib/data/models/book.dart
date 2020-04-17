import 'package:flutter/foundation.dart';

@immutable
class BookEntity {
  final int id;
  final String name;
  final String author;
  final String thumbUrl;
  final String imageUrl;
  final String description;
  final int categoryId;
  final String categoryName;

  BookEntity({this.id, this.name, this.author, this.thumbUrl, this.imageUrl, this.description, this.categoryId, this.categoryName});
}
