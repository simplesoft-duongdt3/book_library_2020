import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:booklibrary2020/data/service/models/book_response.dart';

class BookRepository {
  ApiService _apiService;

  BookRepository(this._apiService);

  Future<NetworkResponseModel<List<BookEntity>>> getBooks() async {
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

  List<BookEntity> mapBooksResponse(BookResponse response) {
    return response.feed.entry.map((entry) => BookEntity(
        id: int.parse(entry.gsxId.text ?? "0") ?? 0,
        author: entry.gsxAuthor.text ?? "",
        name: entry.gsxName.text ?? "",
        description: entry.gsxDescription.text ?? "",
        thumbUrl: entry.gsxThumburl.text ?? "",
        imageUrl: entry.gsxImageurl.text ?? "",
    )).toList(growable: false);
  }
}
