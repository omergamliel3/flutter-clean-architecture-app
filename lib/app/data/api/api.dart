import 'package:getx_hacker_news_api/app/data/models/article_model.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:getx_hacker_news_api/private/keys.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/top-headlines?language=en&pageSize=100&apiKey=$newsApiKey")
  Future<List<ArticleModel>> getTopHeadlines();
}
