import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

import '../articles_local_datasource.dart';
import 'package:getx_hacker_news_api/app/data/models/article_model.dart';
import 'article.dart';

class ArticlesLocalDatasourceHiveImpl implements ArticlesLocalDatasource {
  final _kArticlesBoxName = 'articles_box';

  @override
  Future<bool> initDb() async {
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }

      Hive.registerAdapter(ArticleAdapter());
      await Hive.openBox<Article>(_kArticlesBoxName);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteDb() async {
    // TODO: implement deleteDb
    throw UnimplementedError();
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    // return articles hive box
    final articlesBox = Hive.box<Article>(_kArticlesBoxName);
    return articlesBox.values.map<ArticleModel>((e) {
      return ArticleModel(
          title: e.title,
          content: e.content,
          publishedAt: DateTime.parse(e.publishedAt),
          url: e.url,
          urlToImage: e.urlToImage);
    }).toList();
  }

  @override
  Future<bool> insertArticles(List<ArticleModel> articles) async {
    try {
      // return articles hive box
      final articlesBox = Hive.box<Article>(_kArticlesBoxName);
      // clear all enrties from hive box
      final deleted = await articlesBox.clear();
      // print deleted entries
      print('delete $deleted entries from hive $_kArticlesBoxName box');
      // convert ArticleModel to HiveType Article
      final converted = articles
          .map((e) => Article(
              title: e.title,
              content: e.content,
              publishedAt: e.publishedAt.toIso8601String(),
              url: e.url,
              urlToImage: e.urlToImage))
          .toList();
      // insert all articles to hive box
      final entries = await articlesBox.addAll(converted);
      print(entries);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteAllArticles() async {
    try {
      // return articles hive box
      final articlesBox = Hive.box<Article>(_kArticlesBoxName);
      // clear all enrties from hive box
      final deleted = await articlesBox.clear();
      // print deleted entries
      print('delete $deleted entries from hive $_kArticlesBoxName box');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
