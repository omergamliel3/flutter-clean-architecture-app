import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/domain/entities/article.dart';
import 'package:getx_hacker_news_api/app/domain/repositories/articles_repository.dart';
import 'package:getx_hacker_news_api/app/domain/usecases/get_local_articles.dart';

class ArticlesRepositoryMock extends Mock implements ArticlesRepository {}

void main() {
  GetLocalArticles usecase;
  ArticlesRepository articlesRepositoryMock;

  setUp(() {
    articlesRepositoryMock = ArticlesRepositoryMock();
    usecase = GetLocalArticles(articlesRepositoryMock);
  });

  test('should get articles from the repository', () async {
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

    // arrange
    when(articlesRepositoryMock.getLocalArticles())
        .thenAnswer((realInvocation) => Future.value(Right(articles)));

    // act
    final result = await usecase.call();

    // assert
    expect(result, Right(articles));
    verify(articlesRepositoryMock.getLocalArticles());
    verifyNoMoreInteractions(articlesRepositoryMock);
  });

  test('should get failure from the repository', () async {
    const failure = Failure('something went wrong');
    // arrange
    when(articlesRepositoryMock.getLocalArticles())
        .thenAnswer((realInvocation) => Future.value(const Left(failure)));

    // act
    final result = await usecase.call();

    // assert
    expect(result, const Left(failure));
    verify(articlesRepositoryMock.getLocalArticles());
    verifyNoMoreInteractions(articlesRepositoryMock);
  });
}
