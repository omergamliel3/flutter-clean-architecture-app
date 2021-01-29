import 'package:getx_hacker_news_api/app/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';

import 'package:getx_hacker_news_api/app/domain/repositories/articles_repository.dart';
import 'package:getx_hacker_news_api/app/domain/usecases/get_local_articles.dart';

import '../../test_helper.dart';

class ArticlesRepositoryMock extends Mock implements ArticlesRepository {}

void main() {
  GetLocalArticles usecase;
  ArticlesRepository articlesRepositoryMock;

  setUp(() {
    articlesRepositoryMock = ArticlesRepositoryMock();
    usecase = GetLocalArticles(articlesRepositoryMock);
  });

  test('should get local articles from the repository', () async {
    // arrange
    when(articlesRepositoryMock.getLocalArticles())
        .thenAnswer((realInvocation) => Future.value(Right(articles)));

    // act
    final result = await usecase.call(NoParams());

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
    final result = await usecase.call(NoParams());

    // assert
    expect(result, const Left(failure));
    verify(articlesRepositoryMock.getLocalArticles());
    verifyNoMoreInteractions(articlesRepositoryMock);
  });
}
