import 'dart:convert';

import 'package:alice/alice.dart';
import 'package:booklibrary2020/common/crash_reporting/crash_report.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Alice alice = kDebugMode ? Alice(showNotification: true) : null;

Dio createDioInstance() {
  final BaseOptions baseOptions = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
  );

  final Dio dio = Dio(baseOptions);
  dio.interceptors.add(HeaderInterceptor());
  if (kDebugMode) {
    dio.interceptors.add(getAliceInstance().getDioInterceptor());
    dio.interceptors.add(PrettyDioLogger());
  }

  return dio;
}

GlobalKey<NavigatorState> getAliceNavigatorKey() {
  return alice?.getNavigatorKey();
}

Alice getAliceInstance() {
  return alice;
}

Future<NetworkResult<T>> handleNetworkResult<T>(
  Future<T> request,
) async {
  try {
    final dynamic response = await request;

    if (response is T) {
      return NetworkResult<T>(response: response);
    }
    throw Exception();
  } on DioError catch (e, stackTrace) {

    NetworkResult<T> networkResult =
        NetworkResult<T>(error: NetworkError.DEFAULT);

    CrashReport.getInstance().reportError(exception: e, stackTrace: stackTrace);

    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        networkResult = NetworkResult<T>(error: NetworkError.CONNECT_TIMEOUT);
        break;
      case DioErrorType.SEND_TIMEOUT:
        networkResult = NetworkResult<T>(error: NetworkError.PROCESS_TIMEOUT);
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        networkResult = NetworkResult<T>(error: NetworkError.PROCESS_TIMEOUT);
        break;
      case DioErrorType.RESPONSE:
        networkResult = NetworkResult<T>(error: NetworkError.SERVER_ERROR);
        break;
      case DioErrorType.CANCEL:
        networkResult = NetworkResult<T>(error: NetworkError.CANCEL);
        break;
      case DioErrorType.DEFAULT:
        networkResult = NetworkResult<T>(error: NetworkError.DEFAULT);
        break;
    }
    return networkResult;
  } catch (ex, stackTrace) {
    CrashReport.getInstance().reportError(exception: ex, stackTrace: stackTrace);
    return NetworkResult<T>(error: NetworkError.DEFAULT);
  }
}

enum NetworkError {
  CONNECT_TIMEOUT,
  PROCESS_TIMEOUT,
  SERVER_ERROR,
  CANCEL,
  DEFAULT,
}

class NetworkResult<T> {
  final T response;
  final NetworkError error;

  NetworkResult({this.response, this.error = NetworkError.DEFAULT});

  bool isSuccess() {
    return response != null;
  }
}

class NetworkResponseModel<T> {
  final T responseModel;
  final NetworkError error;

  NetworkResponseModel({this.responseModel, this.error = NetworkError.DEFAULT});

  bool isSuccess() {
    return responseModel != null;
  }
}


class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    String url = options.uri.toString();
    String body = ((options.data is String) ? options.data : (options.data != null ? jsonEncode(options.data) : "")) ?? "";
    HttpMethod method = HttpMethod.GET;
    if (options.method == 'POST') {
      method = HttpMethod.POST;
    }

    Map<String, dynamic> headers = await _buildHeaders(url, body, method);
    options.headers.addAll(headers);
  }

  Future<Map<String, String>> _buildHeaders(
      String url, String body, HttpMethod method) async {
    Map<String, String> headers = {};
    return headers;
  }
}

enum HttpMethod {
  GET,
  POST,
}
