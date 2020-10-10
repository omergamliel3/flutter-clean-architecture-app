import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../models/articles_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../core/errors/failure.dart';
import '../../../private/keys.dart';

class ArticlesRemoteDatasource {
  final Client client;
  ArticlesRemoteDatasource({@required this.client});
  // api endpoint
  final String endpoint =
      'https://newsapi.org/v2/top-headlines?language=en&pageSize=100&apiKey=$newsApiKey';
  final errorMsg = 'Something went wrong';

  /// get articles from api endpoint
  /// return Failure if catch error or status code is not 200
  /// return decoded data as Map if status code is 200
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      var response = await client.get(endpoint);
      if (response.statusCode != 200) {
        var error = json.decode(response.body)['message'] as String ?? errorMsg;
        return Left(Failure(error));
      }
      var data = json.decode(response.body) as Map<String, dynamic>;
      return Right(extractData(data));
    } on Exception catch (_) {
      return Left(Failure(errorMsg));
    }
  }

  /// extract data from http api response
  List<ArticleModel> extractData(Map<String, dynamic> rawData) {
    try {
      var articlesLength = rawData['articles'].length;
      if (articlesLength == 0) {
        return null;
      }
      var articles = <ArticleModel>[];
      for (var i = 0; i < articlesLength; i++) {
        var article = ArticleModel.fromJsonMap(rawData['articles'][i]);
        articles.add(article);
      }
      return articles;
    } on Exception catch (_) {
      return null;
    }
  }
}
