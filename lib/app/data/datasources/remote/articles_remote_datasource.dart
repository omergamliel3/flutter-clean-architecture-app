import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:getx_hacker_news_api/app/data/api/api.dart';
import 'package:getx_hacker_news_api/app/data/models/article_model.dart';
import 'package:getx_hacker_news_api/app/core/errors/failure.dart';

const ERROR_MSG = 'Something went wrong';

class ArticlesRemoteDatasource {
  final RestClient client;
  ArticlesRemoteDatasource({@required this.client});

  /// get articles from api endpoint
  /// return Failure if catch error or status code is not 200
  /// return decoded data as Map if status code is 200
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      final articles = await client.getTopHeadlines();
      return Right(articles);
    } on DioError catch (error) {
      print(error.type);
      print(error.message);
      return Left(Failure(error.message));
    } on Exception catch (_) {
      return const Left(Failure(ERROR_MSG));
    }
  }
}
