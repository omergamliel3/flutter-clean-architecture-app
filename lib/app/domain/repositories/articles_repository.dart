import 'package:dartz/dartz.dart';
import '../../core/models/article_model.dart';
import '../../core/models/failure.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<Article>>> getNetworkArticles();
  Future<Either<Failure, List<Article>>> getLocalArticles();
}
