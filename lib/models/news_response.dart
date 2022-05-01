import 'package:news_application/models/models.dart';

class NewsResponse {
  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
    this.code,
    this.message,
  });

  String? status;
  String? code;
  String? message;
  int? totalResults;
  List<Article?>? articles;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? null
            : List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? null
            : List<dynamic>.from(articles!.map((x) => x?.toJson())),
      };
}
