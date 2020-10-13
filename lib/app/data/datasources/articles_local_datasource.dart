import 'dart:io';

import '../models/articles_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ArticlesLocalDatasource {
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

  /// save articles
  Future<bool> saveArticles(List<ArticleModel> articles) async {
    if (articles == null || articles.isEmpty) return false;
    await deleteAllArticles();
    articles = validateData(articles);
    try {
      for (var article in articles) {
        await _db.transaction(
          (txn) async {
            await txn.rawInsert('''
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
              "${article.publishedAt.toIso8601String()}",
              "${article.url}",
              "${article.urlToImage}"
            )''');
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

  /// delete all articles
  Future<bool> deleteAllArticles() async {
    try {
      await _db.rawDelete('''
        DELETE FROM $_kDBTableName
      ''');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// get all saved articles from db
  Future<List<ArticleModel>> getArticles() async {
    List<Map> jsons = await _db.rawQuery('SELECT * FROM $_kDBTableName');
    return jsons.map((e) => ArticleModel.fromJsonMap(e)).toList();
  }

  /// validate Articles data to evoid database exception
  List<ArticleModel> validateData(List<ArticleModel> articles) {
    var validArticles = <ArticleModel>[];
    for (var article in articles) {
      var validTitle = article.title?.replaceAll('\"', '\'');
      var validContent = article.content?.replaceAll('\"', '\'');
      var validArticle = ArticleModel(
          title: validTitle,
          content: validContent,
          publishedAt: article.publishedAt,
          url: article.url,
          urlToImage: article.urlToImage);
      validArticles.add(validArticle);
    }
    return validArticles;
  }
}
