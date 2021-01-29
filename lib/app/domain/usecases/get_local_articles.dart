import 'package:dartz/dartz.dart';

import '../repositories/articles_repository.dart';

import '../../domain/entities/article.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/core/usecases/usecase.dart';

class GetLocalArticles implements UseCase<List<Article>, NoParams> {
  final ArticlesRepository repository;
  GetLocalArticles(this.repository);
  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 1));
    return repository.getLocalArticles();
  }
}
