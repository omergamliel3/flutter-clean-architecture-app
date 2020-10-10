import 'dart:convert';

import '../../domain/entities/article.dart';
import 'package:meta/meta.dart';

@immutable
class ArticleModel extends Article {
  final String title;
  final String content;
  final String publishedAt;
  final String url;
  final String urlToImage;
  ArticleModel({
    @required this.title,
    @required this.content,
    @required this.publishedAt,
    @required this.url,
    @required this.urlToImage,
  });

  ArticleModel copyWith({
    String title,
    String content,
    String publishedAt,
    String url,
    String urlToImage,
  }) {
    return ArticleModel(
      title: title ?? this.title,
      content: content ?? this.content,
      publishedAt: publishedAt ?? this.publishedAt,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
    );
  }

  Map<String, dynamic> toJsonMap() {
    return {
      'title': title,
      'content': content,
      'publishedAt': publishedAt,
      'url': url,
      'urlToImage': urlToImage,
    };
  }

  factory ArticleModel.fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ArticleModel(
      title: map['title'],
      content: map['content'],
      publishedAt: map['publishedAt'],
      url: map['url'],
      urlToImage: map['urlToImage'],
    );
  }

  String toJson() => json.encode(toJsonMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromJsonMap(json.decode(source));
}
