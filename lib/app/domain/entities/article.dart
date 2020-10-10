import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Article extends Equatable {
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

  @override
  List<Object> get props => [title, content, publishedAt, url, urlToImage];
}
