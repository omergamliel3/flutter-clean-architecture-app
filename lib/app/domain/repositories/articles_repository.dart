import 'package:dartz/dartz.dart';
import '../../domain/entities/article.dart';
import 'package:getx_hacker_news_api/app/core/errors/failure.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<Article>>> getRemoteArticles();
  Future<Either<Failure, List<Article>>> getLocalArticles();
}
