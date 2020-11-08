import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/data/datasources/remote/articles_remote_datasource.dart';
import 'package:getx_hacker_news_api/app/data/models/article_model.dart';
import 'package:getx_hacker_news_api/app/data/repositories/articles_repository_impl.dart';
import 'package:getx_hacker_news_api/app/data/datasources/local/articles_local_datasource.dart';

class ArticlesLocalDatasourceMock extends Mock
    implements ArticlesLocalDatasource {}

class ArticlesRemoteDatasourceMock extends Mock
    implements ArticlesRemoteDatasource {}

void main() {
  ArticlesLocalDatasource localDatasource;
  ArticlesRemoteDatasource remoteDatasource;
  ArticlesRepositoryImpl repository;

  setUp(() {
    localDatasource = ArticlesLocalDatasourceMock();
    remoteDatasource = ArticlesRemoteDatasourceMock();
    repository = ArticlesRepositoryImpl(
        localDataSource: localDatasource, remoteDataSource: remoteDatasource);
  });

  final articles = <ArticleModel>[
    ArticleModel(
        title: 'test',
        content: 'test',
        publishedAt: DateTime.now(),
        url: 'url',
        urlToImage: 'url')
  ];
  group('remote articles:', () {
    test(
        'should return articles data when the call to remoteDataSource is successful, and insert articles to localDataSource',
        () async {
      // arrange
      when(remoteDatasource.getArticles())
          .thenAnswer((realInvocation) => Future.value(Right(articles)));

      // act
      final result = await repository.getRemoteArticles();

      // assert
      expect(result, Right(articles));
      verify(remoteDatasource.getArticles());
      verify(localDatasource.insertArticles(articles));
      verifyNoMoreInteractions(remoteDatasource);
      verifyNoMoreInteractions(localDatasource);
    });

    test('should return failure when the call to remoteDataSource is failed',
        () async {
      const failure = Failure('something went wrong');

      // arrange
      when(remoteDatasource.getArticles())
          .thenAnswer((realInvocation) => Future.value(const Left(failure)));

      // act
      final result = await repository.getRemoteArticles();

      // assert
      expect(result, const Left(failure));
      verify(remoteDatasource.getArticles());
      verifyNoMoreInteractions(remoteDatasource);
      verifyZeroInteractions(localDatasource);
    });
  });

  group('local articles:', () {
    test(
        'should return articles data when the call to localDataSource return with none empty or null data',
        () async {
      // arrange
      when(localDatasource.getArticles())
          .thenAnswer((realInvocation) => Future.value(articles));

      // act
      final result = await repository.getLocalArticles();

      // assert
      expect(result, Right(articles));
      verify(localDatasource.getArticles());
      verifyNoMoreInteractions(localDatasource);
    });

    test(
        'should return failure when the call to localDataSource return with empty or null data',
        () async {
      // arrange
      when(localDatasource.getArticles())
          .thenAnswer((realInvocation) => Future.value([]));

      // act
      final result = await repository.getLocalArticles();

      // assert
      expect(result, isA<Left>());
      verify(localDatasource.getArticles());
      verifyNoMoreInteractions(localDatasource);
    });
  });
}
