import 'package:booklibrary2020/data/models/book.dart';
import 'package:flutter/cupertino.dart';

class BookCacheManager {
  DateTime _lastTimeCached;
  List<BookEntity> _items;

  bool isCached() {
    return _items != null &&
        (_lastTimeCached != null &&
            DateTime.now().difference(_lastTimeCached).inMinutes < 30);
  }

  void setBooks(List<BookEntity> items) {
    _lastTimeCached = DateTime.now();
    _items = items.toList();
  }

  List<BookEntity> getBooks(GetBookRequest filterBookRequest) {
    var cloneList = _items.toList();
    cloneList.sort((a, b) => b.updateDate.compareTo(a.updateDate));
    Iterable<BookEntity> itemsAfterFilter = cloneList;

    if (filterBookRequest is GetAllGetBookRequest) {
      //NOTHING TO DO here get all books
    } else if (filterBookRequest is SearchGetBookRequest) {
      if (filterBookRequest.categoryId != null &&
          filterBookRequest.categoryId > 0) {
        itemsAfterFilter = itemsAfterFilter
            .where((book) => book.categoryId == filterBookRequest.categoryId);
      }

      if (filterBookRequest.searchTerm != null &&
          filterBookRequest.searchTerm.isNotEmpty) {
        itemsAfterFilter = itemsAfterFilter.where((book) {
          return book.name.contains(filterBookRequest.searchTerm) ||
              book.author.contains(filterBookRequest.searchTerm) ||
              book.description.contains(filterBookRequest.searchTerm);
        });
      }
    } else if (filterBookRequest is CategoryFilterGetBookRequest) {
      if (filterBookRequest.categoryId != null &&
          filterBookRequest.categoryId > 0) {
        itemsAfterFilter = itemsAfterFilter
            .where((book) => book.categoryId == filterBookRequest.categoryId);
      }
    }

    return itemsAfterFilter.toList(growable: false);
  }
}

abstract class GetBookRequest {}

class GetAllGetBookRequest extends GetBookRequest {}

class SearchGetBookRequest extends GetBookRequest {
  final String searchTerm;
  final int categoryId;

  SearchGetBookRequest({
    @required this.searchTerm,
    @required this.categoryId,
  });
}

class CategoryFilterGetBookRequest extends GetBookRequest {
  final int categoryId;

  CategoryFilterGetBookRequest({
    @required this.categoryId,
  });
}
