import 'package:booklibrary2020/common/common.dart';
import 'package:dio/dio.dart';
import 'package:booklibrary2020/data/service/models/book_response.dart';
import 'package:booklibrary2020/data/service/models/category_response.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';


final apiServiceInstance = ApiService(createDioInstance());

//RUN CMD `flutter pub run build_runner build` after change this file
@RestApi(baseUrl: "https://spreadsheets.google.com/")
abstract class ApiService {

  factory ApiService(Dio dio) = _ApiService;

  @GET("/feeds/list/1O6B7B3JPYyt-pPCYthfQ7BN-cP2V0urW9A40I8gTtcg/od6/public/values?alt=json")
  Future<BookResponse> getBooks();

  @GET("/feeds/list/1O6B7B3JPYyt-pPCYthfQ7BN-cP2V0urW9A40I8gTtcg/ogvd7pd/public/values?alt=json")
  Future<CategoryResponse> getCategories();
}