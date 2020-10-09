import 'package:meta/meta.dart';

class Article {
  final String title;
  final String content;
  final String publishedAt;
  final String url;
  final String urlToImage;

  Article(
      {@required this.title,
      this.content,
      this.publishedAt,
      this.url,
      this.urlToImage});

  Article.fromJsonMap(Map<String, dynamic> map)
      : title = map['title'],
        content = map['content'],
        publishedAt = map['publishedAt'],
        url = map['url'],
        urlToImage = map['urlToImage'];

  Map<String, dynamic> toJsonMap() => {
        'title': title,
        'content': content,
        'publishedAt': publishedAt,
        'url': url,
        'urlToImage': urlToImage
      };
}
