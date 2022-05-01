import 'dart:convert';

class News {
  String? _source;
  String? _author;
  String? _title;
  String? _description;
  String? _urlToImage;
  String? _publishedAt;
  String? _content;
  int? _id;

  News(
    this._id,
    this._title,
    this._description,
    this._content,
    this._author,
    this._urlToImage,
    this._publishedAt,
    this._source,
  );

  String? get source => _source;
  String? get publishedAt => _publishedAt;
  String? get urlToImage => _urlToImage;
  String? get author => _author;
  String? get content => _content;
  String? get description => _description;
  String? get title => _title;
  int? get id => _id;

  Map<String, dynamic> toMap() {
    return {
      if (_id != null) 'id': _id,
      'title': title,
      'description': description,
      'content': content,
      'author': author,
      'source': source,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      map['_id']?.toInt(),
      map['title'],
      map['description'],
      map['content'],
      map['author'],
      map['urlToImage'],
      map['publishedAt'],
      map['source'],
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));
}
