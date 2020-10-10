import '../../core/models/article_model.dart';
import '../../core/models/failure.dart';
import '../datasources/articles_local_datasource.dart';
import '../datasources/articles_remote_datasource.dart';
import '../../domain/repositories/articles_repository.dart';

import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl(
      {@required this.localDataSource, @required this.remoteDataSource});
  // local data source
  final ArticlesLocalDatasource localDataSource;
  // remote data source
  final ArticlesRemoteDatasource remoteDataSource;

  /// return either failure or list of articles
  @override
  Future<Either<Failure, List<Article>>> getNetworkArticles() async {
    try {
      List<Article> articles;
      var response = await remoteDataSource.getArticles();
      response.fold(
          (failure) => failure, (data) => articles = extractData(data));
      if (articles == null) return Left(Failure('Something went wrong'));
      await localDataSource.saveArticles(articles);
      return Right(articles);
    } on Exception catch (_) {
      return Left(Failure('Something went wrong'));
    }
  }

  /// return either failure or list of articles from saved local database
  @override
  Future<Either<Failure, List<Article>>> getLocalArticles() async {
    var articles = await localDataSource.getArticles();
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
      var articles = <Article>[];
      for (var i = 0; i < articlesLength; i++) {
        var article = Article.fromJsonMap(rawData['articles'][i]);
        articles.add(article);
      }
      return articles;
    } on Exception catch (_) {
      return null;
    }
  }
}
