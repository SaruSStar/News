import 'package:dio/dio.dart';
import 'package:news_application/constants/app_constants.dart';
import 'package:news_application/models/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:news_application/constants/.keys.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class RestClient {
  // factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;
  factory RestClient(
    Dio dio, {
    String? baseUrl,
  }) {
    dio.options.headers.addAll({"X-Api-Key": Keys.api});
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    return _RestClient(dio, baseUrl: baseUrl);
  }

  @GET("/everything")
  Future<NewsResponse> getNews({
    ///The fields to restrict your q search to.
    /// The possible options are: title, description, content
    /// Multiple options can be specified by separating them with a comma,
    /// example: title,content.
    @Query('searchIn') String? searchIn,
    @Query('q') String? query,

    /// Use this to page through the results.
    @Query('page') int? page,

    /// The number of results to return per page.
    /// max and default is 100
    @Query('pageSize') int? pageSize,
    @Query('sources') String? sources, // source id

    /// format (e.g. 2022-04-29 or 2022-04-29T15:28:36)
    @Query('from') String? from,
    @Query('to') String? to,

    /// Find sources that display news in a specific language.
    /// Possible options: ar, de, en, es ,fr ,he ,it ,nl ,no ,pt, ru, sv, ud ,zh.
    /// Default: all languages.
    @Query('language') String? language,

    /// The order to sort the articles in. Possible options: relevancy, popularity, publishedAt.
    /// relevancy = articles more closely related to q come first.
    /// popularity = articles from popular sources and publishers come first.
    /// publishedAt = newest articles come first.
    /// Default: publishedAt
    @Query('sortBy') String? sortBy,
  });

  @GET("/top-headlines")
  Future<NewsResponse> getTopNews({
    @Query('q') String? query,
    @Query('searchIn') String? searchIn,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sources') String? sources,
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('language') String? language,
    @Query('sortBy') String? sortBy,
  });

  @GET("/top-headlines/sources")
  Future<SourceResponse> getSources();
}
