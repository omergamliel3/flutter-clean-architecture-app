import 'dart:convert';

import '../../domain/entities/article.dart';
import 'package:meta/meta.dart';

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

  ArticleModel copyWith({
    String title,
    String content,
    DateTime publishedAt,
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
      'publishedAt': publishedAt.toIso8601String(),
      'url': url,
      'urlToImage': urlToImage,
    };
  }

  factory ArticleModel.fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ArticleModel(
      title: map['title'] as String ?? '',
      content: map['content'] as String ?? '',
      publishedAt: DateTime.parse(map['publishedAt'] as String),
      url: map['url'] as String ?? '',
      urlToImage: map['urlToImage'] as String ?? '',
    );
  }

  String toJson() => json.encode(toJsonMap());
}
