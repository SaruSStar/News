import 'dart:io';

import 'package:news_application/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperUser {
  static final DatabaseHelperUser _instance = DatabaseHelperUser.internal();

  factory DatabaseHelperUser() => _instance;

  final String _tableUser = "UserTable";
  final String _columnId = "id";
  final String _columnName = "name";
  final String _columnUsername = "username";
  final String _columnPassword = "password";

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelperUser.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join((documentDirectory.path),
        'maindb.db'); // home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $_tableUser($_columnId INTEGER PRIMARY KEY, $_columnName TEXT, $_columnUsername TEXT, $_columnPassword TEXT)");
  }

  /// INSERT
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient!.insert(_tableUser, user.toMap());
    return res;
  }

  /// READ
  Future<User?> loginUser(String username, String password) async {
    var dbClient = await db;
    List<Map<String, Object?>> res = await dbClient!
        .rawQuery("SELECT * FROM $_tableUser WHERE $_columnUsername='$username' AND $_columnPassword='$password'");
    if (res.isEmpty) return null;
    return User.fromMap(res.first);
  }

  Future<User?> getUser(String username) async {
    var dbClient = await db;
    List<Map<String, Object?>> res = await dbClient!
        .rawQuery("SELECT * FROM $_tableUser WHERE $_columnUsername='$username'");
    if (res.isEmpty) return null;
    final user = User.fromMap(res.first);
    return user;
  }

  Future<int> deleteUser(String username) async {
    var dbClient = await db;
    int res = await dbClient!
        .delete(_tableUser, where: "$_columnUsername='?'", whereArgs: [username]);
    return res;
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    int res = await dbClient!.update(_tableUser, user.toMap(),
        where: "$_columnUsername='?'", whereArgs: [user.username]);
    return res;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
