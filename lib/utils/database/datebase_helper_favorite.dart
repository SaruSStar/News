import 'dart:io';

import 'package:news_application/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperFavorite {
  static final DatabaseHelperFavorite _instance =
      DatabaseHelperFavorite.internal();

  factory DatabaseHelperFavorite() => _instance;

  final String _tableFavorite = "FavoriteTable";
  final String _columnId = "id";
  final String _columnTitle = "title";
  final String _columnDescription = "description";
  final String _columnContent = "content";
  final String _columnAuthor = "author";
  final String _columnUrlToImage = "urlToImage";
  final String _columnPublishedAt = "publishedAt";
  final String _columnSource = "source";

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelperFavorite.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join((documentDirectory.path),
        'maindb1.db'); // home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $_tableFavorite($_columnId INTEGER PRIMARY KEY, $_columnTitle TEXT, $_columnDescription TEXT, $_columnContent TEXT, $_columnAuthor TEXT, $_columnUrlToImage TEXT, $_columnPublishedAt TEXT, $_columnSource TEXT)");
  }

  /// INSERT
  Future<int> addToFavourite(News news) async {
    var dbClient = await db;
    int res = await dbClient!.insert(_tableFavorite, news.toMap());
    return res;
  }

  /// READ
  Future<List<News>?> getFavoriteItems() async {
    var dbClient = await db;
    List<Map<String, Object?>> res =
        await dbClient!.rawQuery("SELECT * FROM $_tableFavorite");
    if (res.isEmpty) return null;
    return res.map((e) => News.fromMap(e)).toList();
  }

  Future<int> removeFromFavorite(int id) async {
    var dbClient = await db;
    int res = await dbClient!
        .delete(_tableFavorite, where: "$_columnId=?", whereArgs: [id]);
    return res;
  }

  Future<int> updateFavorite(News news) async {
    var dbClient = await db;
    int res = await dbClient!.update(_tableFavorite, news.toMap(),
        where: '$_columnId=?', whereArgs: [news.id]);
    return res;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
