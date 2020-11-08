import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:getx_hacker_news_api/app/domain/entities/article.dart';

part 'article_model.g.dart';

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
