import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:getx_hacker_news_api/app/core/models/article.dart';

class LocalDatabase {
  final _kDbFileName = 'sqflite_ex.db';
  final _kDBTableName = 'articles_table';
  Database _db;

  /// Opens a db local file. Creates the db table if it's not yet created.
  Future<bool> initDb() async {
    try {
      // get database path directory
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _kDbFileName);
      // open db
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initArticlesTable(db);
        },
      );
      // success init db
      return true;
    } on DatabaseException catch (e) {
      // failed to init db
      print(e);
      return false;
    }
  }

  /// delete the database
  Future<void> deleteDB() async {
    final dbFolder = await getDatabasesPath();
    if (!await Directory(dbFolder).exists()) {
      await Directory(dbFolder).create(recursive: true);
    }
    final dbPath = join(dbFolder, _kDbFileName);
    await deleteDatabase(dbPath);
    _db = null;
  }

  // creates articles table
  Future<void> _initArticlesTable(Database db) async {
    await db.execute('''
          CREATE TABLE $_kDBTableName(
          id INTEGER PRIMARY KEY, 
          title TEXT,
          content TEXT,
          publishedAt TEXT,
          url TEXT,
          urlToImage TEXT
          )
        ''');
  }

  /// save articles in database
  Future<bool> saveArticles(List<Article> articles) async {
    if (articles == null || articles.isEmpty) return false;
    try {
      for (var article in articles) {
        await _db.transaction(
          (txn) async {
            int id = await txn.rawInsert('''
          INSERT INTO $_kDBTableName 
          (
          title,
          content,
          publishedAt,
          url,
          urlToImage
          )
          VALUES
            (
              "${article.title}",
              "${article.content}",
              "${article.publishedAt}",
              "${article.url}",
              "${article.urlToImage}"
            )''');
            print('create new record with id: $id');
          },
        );
      }
      // success inserted data
      return true;
    } on DatabaseException catch (e) {
      // failed to insert data
      print(e);
      return false;
    }
  }

  /// get all saved articles from db
  Future<List<Article>> getArticles() async {
    List<Map> jsons = await _db.rawQuery('SELECT * FROM $_kDBTableName');
    return jsons.map((e) => Article.fromJsonMap(e)).toList();
  }
}
