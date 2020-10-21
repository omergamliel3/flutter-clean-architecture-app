import 'dart:convert';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../models/articles_model.dart';
import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/private/keys.dart';

const ERROR_MSG = 'Something went wrong';

class ArticlesRemoteDatasource {
  final Client client;
  ArticlesRemoteDatasource({@required this.client});
  // api endpoint
  final String endpoint =
      'https://newsapi.org/v2/top-headlines?language=en&pageSize=100&apiKey=$newsApiKey';

  /// get articles from api endpoint
  /// return Failure if catch error or status code is not 200
  /// return decoded data as Map if status code is 200
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      final response = await client.get(endpoint);
      if (response.statusCode != 200) {
        final error =
            json.decode(response.body)['message'] as String ?? ERROR_MSG;
        return Left(Failure(error));
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      return Right(extractData(data));
    } on Exception catch (_) {
      return const Left(Failure(ERROR_MSG));
    }
  }

  /// extract data from http api response
  List<ArticleModel> extractData(Map<String, dynamic> rawData) {
    try {
      final articlesLength = rawData['articles'].length as int;
      if (articlesLength == 0) {
        return null;
      }
      final articles = <ArticleModel>[];
      for (var i = 0; i < articlesLength; i++) {
        final data = rawData['articles'][i] as Map<String, dynamic>;
        final article = ArticleModel.fromJsonMap(data);
        articles.add(article);
      }
      return articles;
    } on Exception catch (_) {
      return null;
    }
  }
}
