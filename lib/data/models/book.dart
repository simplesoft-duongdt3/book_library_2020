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
  final String imageRatio;
  final String releaseTime;
  final String language;
  final String pageCount;
  final DateTime updateDate;

  BookEntity(
      {@required this.id,
      @required this.name,
      @required this.author,
      @required this.thumbUrl,
      @required this.imageUrl,
      @required this.description,
      @required this.categoryId,
      @required this.categoryName,
      @required this.imageRatio,
      @required this.releaseTime,
      @required this.language,
      @required this.updateDate,
      @required this.pageCount});
}
