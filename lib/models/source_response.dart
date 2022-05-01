import 'package:news_application/models/models.dart';

class SourceResponse {
  SourceResponse({
    this.status,
    this.sources,
    this.code,
    this.message,
  });

  String? status;

  String? code;
  String? message;
  List<Source?>? sources;

  factory SourceResponse.fromJson(Map<String, dynamic> json) => SourceResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        sources: json["sources"] == null
            ? null
            : List<Source?>.from(
                json["sources"].map((x) => Source.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sources": sources == null
            ? null
            : List<dynamic>.from(sources!.map((x) => x?.toJson())),
      };
}
