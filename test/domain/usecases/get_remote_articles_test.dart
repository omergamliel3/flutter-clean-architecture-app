import 'package:getx_hacker_news_api/app/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';

import 'package:getx_hacker_news_api/app/domain/usecases/get_remote_articles.dart';
import 'package:getx_hacker_news_api/app/domain/repositories/articles_repository.dart';

import '../../test_helper.dart';

class ArticlesRepositoryMock extends Mock implements ArticlesRepository {}

void main() {
  GetRemoteArticles usecase;
  ArticlesRepository articlesRepositoryMock;

  setUp(() {
    articlesRepositoryMock = ArticlesRepositoryMock();
    usecase = GetRemoteArticles(articlesRepositoryMock);
  });

  test('should get remote articles from the repository', () async {
    // arrange
    when(articlesRepositoryMock.getRemoteArticles())
        .thenAnswer((realInvocation) => Future.value(Right(articles)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, Right(articles));
    verify(articlesRepositoryMock.getRemoteArticles());
    verifyNoMoreInteractions(ArticlesRepositoryMock());
  });

  test('should get failure from the repository', () async {
    const failure = Failure('something went wrong');

    // arrange
    when(articlesRepositoryMock.getRemoteArticles())
        .thenAnswer((realInvocation) => Future.value(const Left(failure)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, const Left(failure));
    verify(articlesRepositoryMock.getRemoteArticles());
    verifyNoMoreInteractions(ArticlesRepositoryMock());
  });
}
