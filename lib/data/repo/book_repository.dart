import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/models/category.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:booklibrary2020/data/service/models/book_response.dart';
import 'package:booklibrary2020/data/service/models/category_response.dart';

class BookRepository {
  ApiService _apiService;

  BookRepository(this._apiService);

  Future<NetworkResponseModel<List<BookEntity>>> getBooks() async {
    //delay for testing
    await Future.delayed(Duration(seconds: 1));

    var requestGetBooks = _apiService.getBooks();
    NetworkResult<BookResponse> getBooksResult =
        await handleNetworkResult(requestGetBooks);

    if (getBooksResult.isSuccess()) {
      return NetworkResponseModel(
          responseModel: mapBooksResponse(getBooksResult.response));
    } else {
      return NetworkResponseModel(error: getBooksResult.error);
    }
  }

  Future<NetworkResponseModel<List<CategoryEntity>>> getCategories() async {
    var requestGetCategories = _apiService.getCategories();
    NetworkResult<CategoryResponse> getCategoriesResult =
        await handleNetworkResult(requestGetCategories);

    if (getCategoriesResult.isSuccess()) {
      return NetworkResponseModel(
          responseModel: mapCategoriesResponse(getCategoriesResult.response));
    } else {
      return NetworkResponseModel(error: getCategoriesResult.error);
    }
  }

  List<BookEntity> mapBooksResponse(BookResponse response) {
    return response.feed.entry.map((entry) => BookEntity(
        id: int.parse(entry.gsxId.text ?? "0") ?? 0,
        author: entry.gsxAuthor.text ?? "",
        name: entry.gsxName.text ?? "",
        description: entry.gsxDescription.text ?? "",
        thumbUrl: entry.gsxThumburl.text ?? "",
        imageUrl: entry.gsxImageurl.text ?? "",
        categoryId: int.parse(entry.gsxCategoryId.text ?? "0") ?? 0,
        categoryName: entry.gsxCategoryName.text ?? ""
    )).toList(growable: false);
  }

  List<CategoryEntity> mapCategoriesResponse(CategoryResponse response) {
    return response.feed.entry.map((entry) => CategoryEntity(
        id: int.parse(entry.gsxId.text ?? "0") ?? 0,
        name: entry.gsxName.text ?? ""
    )).toList(growable: false);
  }
}
