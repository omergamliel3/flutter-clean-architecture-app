import 'package:dartz/dartz.dart';
import '../repositories/articles_repository.dart';

import '../../domain/entities/article.dart';

import '../../core/usecases/usecase.dart';
import '../../core/errors/failure.dart';

class GetLocalArticles implements UseCase<List<Article>> {
  final ArticlesRepository repository;
  GetLocalArticles(this.repository);
  @override
  Future<Either<Failure, List<Article>>> call() async {
    await Future.delayed(Duration(seconds: 2));
    return await repository.getLocalArticles();
  }
}
