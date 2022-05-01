import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:news_application/constants/queries.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/networks/rest_client.dart';

class NewsApi {
  static final Dio _dio = Dio();
  static final Logger _logger = Logger();

  static Future<NewsResponse> getNews({Map<String, dynamic>? queries}) {
    final _client = RestClient(_dio);
    return _client
        .getNews(
      query: queries?[Queries.q],
      language: queries?[Queries.language],
      page: queries?[Queries.page],
      pageSize: queries?[Queries.pageSize],
      searchIn: queries?[Queries.searchIn],
      sortBy: queries?[Queries.sortBy],
      sources: queries?[Queries.sources],
      from: queries?[Queries.from],
      to: queries?[Queries.to],
    )
        .then((newsRes) {
      _logger.i(newsRes);
      return newsRes;
    }).catchError((obj) {
      _logger.e('Got error : type -> ${obj.runtimeType} error -> $obj');
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          return NewsResponse(
              code: res?.statusCode.toString(),
              message:
                  res?.statusMessage ?? (obj.error as SocketException).message,
              status: 'error');
        default:
          return NewsResponse(message: 'Some Error Occurred', status: 'error');
      }
    });
  }

  static Future<NewsResponse> getTopNews({Map<String, dynamic>? queries}) {
    final _client = RestClient(_dio);
    return _client
        .getTopNews(
      query: queries?[Queries.q],
      language: queries?[Queries.language],
      page: queries?[Queries.page],
      pageSize: queries?[Queries.pageSize],
      searchIn: queries?[Queries.searchIn],
      sortBy: queries?[Queries.sortBy],
      sources: queries?[Queries.sources],
      from: queries?[Queries.from],
      to: queries?[Queries.to],
    )
        .then((newsRes) {
      return newsRes;
    }).catchError((obj) {
      _logger.e('Got error : type -> ${obj.runtimeType} error -> $obj');
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          return NewsResponse(
              code: res?.statusCode.toString(),
              message:
                  res?.statusMessage ?? (obj.error as SocketException).message,
              status: 'error');
        default:
          return NewsResponse(message: 'Some Error Occurred', status: 'error');
      }
    });
  }

  static Future<SourceResponse> getSources() {
    final _client = RestClient(_dio);
    return _client.getSources().then((newsRes) {
      return newsRes;
    }).catchError((obj) {
      _logger.e('Got error : type -> ${obj.runtimeType} error -> $obj');
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          return SourceResponse(
              code: res?.statusCode.toString(),
              message:
                  res?.statusMessage ?? (obj.error as SocketException).message,
              status: 'error');
        default:
          return SourceResponse(
              message: 'Some Error Occurred', status: 'error');
      }
    });
  }
}
