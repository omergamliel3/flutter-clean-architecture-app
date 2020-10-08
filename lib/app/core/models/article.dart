import 'package:meta/meta.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String publishedAt;
  final String url;
  final String urlToImage;

  Article(
      {@required this.title,
      this.description,
      this.content,
      this.publishedAt,
      this.url,
      this.urlToImage});

  Article.fromJsonMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'],
        content = map['content'],
        publishedAt = map['publishedAt'],
        url = map['url'],
        urlToImage = map['urlToImage'];

  Map<String, dynamic> toJsonMap() => {'title': title};
}
