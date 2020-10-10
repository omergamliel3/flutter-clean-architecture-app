import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
class Article {
  final String title;
  final String content;
  final String publishedAt;
  final String url;
  final String urlToImage;
  Article({
    @required this.title,
    @required this.content,
    @required this.publishedAt,
    @required this.url,
    @required this.urlToImage,
  });

  Article copyWith({
    String title,
    String content,
    String publishedAt,
    String url,
    String urlToImage,
  }) {
    return Article(
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

  factory Article.fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Article(
      title: map['title'],
      content: map['content'],
      publishedAt: map['publishedAt'],
      url: map['url'],
      urlToImage: map['urlToImage'],
    );
  }

  String toJson() => json.encode(toJsonMap());

  factory Article.fromJson(String source) =>
      Article.fromJsonMap(json.decode(source));

  @override
  String toString() {
    return '''Article(title: $title, content: $content, publishedAt: $publishedAt, url: $url, urlToImage: $urlToImage)''';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Article &&
        o.title == title &&
        o.content == content &&
        o.publishedAt == publishedAt &&
        o.url == url &&
        o.urlToImage == urlToImage;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        publishedAt.hashCode ^
        url.hashCode ^
        urlToImage.hashCode;
  }
}
