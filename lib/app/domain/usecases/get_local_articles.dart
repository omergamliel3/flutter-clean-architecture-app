import 'package:dartz/dartz.dart';
import '../repositories/articles_repository.dart';

import '../../core/models/failure.dart';

import '../../core/models/article_model.dart';
import '../../core/usecases/usecase.dart';

class GetLocalArticles implements UseCase<List<Article>> {
  final ArticlesRepository repository;
  GetLocalArticles(this.repository);
  @override
  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getLocalArticles();
  }
}
