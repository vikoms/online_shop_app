import 'package:sqflite/sqflite.dart';

import '../model/wishlist_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWishlist = 'wishlist';
  static const String _tblCart = 'carts';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWishlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price TEXT,
        photo TEXT,
        category TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCart (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price TEXT,
        photo TEXT,
        category TEXT
      );
    ''');
  }

  Future<int> insertWishlist(WishListModel wishlist) async {
    final db = await database;
    return await db!.insert(
      _tblWishlist,
      wishlist.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeWishlist(int id) async {
    final db = await database;
    return await db!.delete(
      _tblWishlist,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getWishlistById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWishlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWishlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWishlist);

    return results;
  }

  Future<int> clearWishlist() async {
    final db = await database;
    return await db!.delete(_tblWishlist);
  }
}
