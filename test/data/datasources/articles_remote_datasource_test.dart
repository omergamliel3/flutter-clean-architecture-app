import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/data/api/api.dart';
import 'package:getx_hacker_news_api/app/data/datasources/remote/articles_remote_datasource.dart';

class MockRestClient extends Mock implements RestClient {}

void main() {
  RestClient client;
  ArticlesRemoteDatasource remoteDatasource;
  setUp(() {
    client = MockRestClient();
    remoteDatasource = ArticlesRemoteDatasource(client: client);
  });

  final articles = <ArticleModel>[
    ArticleModel(
        title: 'test',
        content: 'test',
        publishedAt: DateTime.now(),
        url: 'url',
        urlToImage: 'url')
  ];

  test('should return articles data when the call to rest client is successful',
      () async {
    // arrange
    when(client.getTopHeadlines())
        .thenAnswer((realInvocation) => Future.value(articles));

    // act
    final result = await remoteDatasource.getArticles();

    // assert
    expect(result, Right(articles));
    verify(client.getTopHeadlines());
    verifyNoMoreInteractions(client);
  });

  test('should return failure when the call to rest client ends with Exception',
      () async {
    // arrange
    when(client.getTopHeadlines()).thenThrow(Exception());

    // act
    final result = await remoteDatasource.getArticles();

    // assert
    expect(result, isA<Left>());
    verify(client.getTopHeadlines());
    verifyNoMoreInteractions(client);
  });
}
