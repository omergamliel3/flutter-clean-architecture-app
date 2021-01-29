import 'package:dartz/dartz.dart';

import '../repositories/articles_repository.dart';

import '../../domain/entities/article.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/core/usecases/usecase.dart';

class GetRemoteArticles implements UseCase<List<Article>, NoParams> {
  final ArticlesRepository repository;
  GetRemoteArticles(this.repository);
  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return repository.getRemoteArticles();
  }
}
