import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/cache/book_cache_manager.dart';
import 'package:booklibrary2020/data/models/CategoryBookItems.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/models/category.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:booklibrary2020/data/service/models/book_response.dart';
import 'package:booklibrary2020/data/service/models/category_response.dart';
import 'package:intl/intl.dart';

class BookRepository {
  final ApiService _apiService;
  final BookCacheManager _bookCacheManager = BookCacheManager();

  BookRepository(this._apiService);

  /// catId = 0 -> All book
  Future<NetworkResponseModel<List<BookEntity>>> getBooks(FilterBook filterBook) async {
    if (_bookCacheManager.isCached()) {
      return NetworkResponseModel(
          responseModel: _bookCacheManager.getBooks(filterBook));
    } else {
      var requestGetBooks = _apiService.getBooks();
      var getBooksResult = await handleNetworkResult(requestGetBooks);
      if (getBooksResult.isSuccess()) {
        _bookCacheManager.setBooks(mapBooksResponse(getBooksResult.response));
        return NetworkResponseModel(responseModel: _bookCacheManager.getBooks(filterBook));
      } else {
        return NetworkResponseModel(error: getBooksResult.error);
      }
    }
  }

  Future<NetworkResponseModel<List<CategoryEntity>>> getCategories() async {
    var requestGetCategories = _apiService.getCategories();
    var getCategoriesResult =
        await handleNetworkResult(requestGetCategories);

    if (getCategoriesResult.isSuccess()) {
      return NetworkResponseModel(
          responseModel: mapCategoriesResponse(getCategoriesResult.response));
    } else {
      return NetworkResponseModel(error: getCategoriesResult.error);
    }
  }

  Future<NetworkResponseModel<List<CategoryBookItemsEntity>>> getCategoryBookItems() async {
    var requestGetCategories = _apiService.getCategories();
    var getCategoriesResult =
        await handleNetworkResult(requestGetCategories);

    if (getCategoriesResult.isSuccess()) {
      var categories = mapCategoriesResponse(getCategoriesResult.response);
      var categoryBookItemsEntices = <CategoryBookItemsEntity>[];
      for (var i = 0; i < categories.length; i++) {
        var category = categories[i];
        var filter = FilterBook(categoryId: category.id, isGetNewestBooks: true);
        var booksResult = await getBooks(filter);
        var books = [];
        if (booksResult.isSuccess()) {
          if (booksResult.responseModel.length > 5) {
            books = booksResult.responseModel.sublist(0, 5);
          } else {
            books = booksResult.responseModel;
          }
        }
        var categoryBookItem = CategoryBookItemsEntity(
          category: category,
          books: books
        );
        categoryBookItemsEntices.add(categoryBookItem);
      }
      return NetworkResponseModel(
          responseModel: categoryBookItemsEntices);
    } else {
      return NetworkResponseModel(error: getCategoriesResult.error);
    }
  }

  List<BookEntity> mapBooksResponse(BookResponse response) {
    var dateFormat = DateFormat('MM/dd/yyyy');
    return response.feed.entry
        .map((entry) => BookEntity(
              id: int.parse(entry.gsxId.text ?? "0") ?? 0,
              author: entry.gsxAuthor.text ?? "",
              name: entry.gsxName.text ?? "",
              description: entry.gsxDescription.text ?? "",
              thumbUrl: entry.gsxThumburl.text ?? "",
              imageUrl: entry.gsxImageurl.text ?? "",
              categoryId: int.parse(entry.gsxCategoryId.text ?? "0") ?? 0,
              categoryName: entry.gsxCategoryName.text ?? "",
              imageRatio: entry.gsxImageRatio.text ?? "",
              language: entry.gsxLanguage.text ?? "",
              pageCount: entry.gsxPageCount.text ?? "",
              releaseTime: entry.gsxReleaseTime.text ?? "",
              updateDate: mapUpdateDate(entry.gsxUpdateDate.text, dateFormat)
            ))
        .toList(growable: false);
  }

  DateTime mapUpdateDate(String updateDate, DateFormat dateFormat) {
    if(updateDate != null)  {
      return dateFormat.parse(updateDate);
    } else {
      return DateTime.now();
    }
  }

  List<CategoryEntity> mapCategoriesResponse(CategoryResponse response) {
    return response.feed.entry
        .map((entry) => CategoryEntity(
            id: int.parse(entry.gsxId.text ?? "0") ?? 0,
            name: entry.gsxName.text ?? ""))
        .toList(growable: false);
  }
}
