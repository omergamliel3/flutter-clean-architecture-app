import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(adapterName: 'ArticleAdapter', typeId: 0)
class Article {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String publishedAt;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String urlToImage;

  Article({
    this.title,
    this.content,
    this.publishedAt,
    this.url,
    this.urlToImage,
  });
}
