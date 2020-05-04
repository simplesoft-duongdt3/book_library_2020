import 'package:booklibrary2020/data/models/book.dart';
import 'package:flutter/cupertino.dart';

class BookCacheManager {
  DateTime _lastTimeCached;
  List<BookEntity> _items;
  bool isCached() {
    return _items != null && (_lastTimeCached != null && DateTime.now().difference(_lastTimeCached).inMinutes < 30);
  }

  void setBooks(List<BookEntity> items) {
    _lastTimeCached = DateTime.now();
    _items = items.toList();
  }

  List<BookEntity> getBooks(FilterBook filterBook) {
    Iterable<BookEntity> itemsAfterFilter = _items;
    if (filterBook.isGetNewestBooks) {
      var cloneList = _items.toList();
      cloneList.sort((a, b) => b.updateDate.compareTo(a.updateDate));
      itemsAfterFilter = cloneList;
    } else if (filterBook.categoryId != null) {
      itemsAfterFilter = itemsAfterFilter.where((element) => element.categoryId == filterBook.categoryId);
    }

    if (filterBook.searchTerm != null) {
      itemsAfterFilter = itemsAfterFilter.where((element) {
        return element.name.contains(filterBook.searchTerm) || element.author.contains(filterBook.searchTerm) || element.description.contains(filterBook.searchTerm);
      });
    }

    return itemsAfterFilter.toList(growable: false);
  }
}

class FilterBook {
  final int categoryId;
  final bool isGetNewestBooks;
  final String searchTerm;

  FilterBook({this.categoryId, @required this.isGetNewestBooks, this.searchTerm});
}
