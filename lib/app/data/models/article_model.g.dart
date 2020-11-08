// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    title: json['title'] as String,
    content: json['content'] as String,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'url': instance.url,
      'urlToImage': instance.urlToImage,
    };
