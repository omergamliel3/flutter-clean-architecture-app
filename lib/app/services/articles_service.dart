import 'package:getx_hacker_news_api/app/data/network/api.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/core/models/article.dart';
import 'package:getx_hacker_news_api/app/core/models/failure.dart';
import 'package:getx_hacker_news_api/app/data/local/local_database.dart';

class ArticlesService {
  ArticlesService({@required this.localDatabase, @required this.api});
  // local database
  final LocalDatabase localDatabase;
  // api
  final Api api;

  /// return either failure or list of articles
  Future<Either<Failure, List<Article>>> getNetworkArticles() async {
    try {
      List<Article> articles;
      var response = await api.getArticles();
      response.fold((failure) => Failure(failure.text),
          (data) => articles = extractData(data));
      if (articles == null) return Left(Failure('Something went wrong'));
      await localDatabase.saveArticles(articles);
      return Right(articles);
    } catch (_) {
      return Left(Failure('Something went wrong'));
    }
  }

  /// return either failure or list of articles from saved local database
  Future<Either<Failure, List<Article>>> getLocalArticles() async {
    var articles = await localDatabase.getArticles();
    if (articles == null || articles.isEmpty) {
      return Left(Failure('No articles saved locally'));
    }
    return Right(articles);
  }

  /// extract data from http api response
  List<Article> extractData(Map<String, dynamic> rawData) {
    try {
      var articlesLength = rawData['articles'].length;
      if (articlesLength == 0) {
        return null;
      }
      List<Article> articles = [];
      for (int i = 0; i < articlesLength; i++) {
        var article = Article.fromJsonMap(rawData['articles'][i]);
        articles.add(article);
      }
      return articles;
    } catch (_) {
      return null;
    }
  }
}
