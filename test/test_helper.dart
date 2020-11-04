import 'package:getx_hacker_news_api/app/domain/entities/article.dart';

final articles = <Article>[
  Article(
      title: 'test1',
      content: 'test1',
      publishedAt: DateTime.now(),
      url: 'url1',
      urlToImage: 'urlToImage1'),
  Article(
      title: 'test2',
      content: 'test2',
      publishedAt: DateTime.now(),
      url: 'url2',
      urlToImage: 'urlToImage2')
];
