import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:getx_hacker_news_api/app/domain/entities/article.dart';
import 'package:getx_hacker_news_api/private/keys.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/top-headlines?language=en&pageSize=100&apiKey=$newsApiKey")
  Future<List<ArticleModel>> getTopHeadlines();
}

@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    @required String title,
    @required String content,
    @required DateTime publishedAt,
    @required String url,
    @required String urlToImage,
  }) : super(
            title: title,
            content: content,
            publishedAt: publishedAt,
            url: url,
            urlToImage: urlToImage);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
