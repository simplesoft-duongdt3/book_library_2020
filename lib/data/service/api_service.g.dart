// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://spreadsheets.google.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getBooks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/feeds/list/1O6B7B3JPYyt-pPCYthfQ7BN-cP2V0urW9A40I8gTtcg/od6/public/values?alt=json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BookResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/feeds/list/1O6B7B3JPYyt-pPCYthfQ7BN-cP2V0urW9A40I8gTtcg/ogvd7pd/public/values?alt=json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CategoryResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
