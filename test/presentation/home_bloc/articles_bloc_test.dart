import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:getx_hacker_news_api/app/domain/usecases/get_local_articles.dart';
import 'package:getx_hacker_news_api/app/domain/usecases/get_remote_articles.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/core/network/network_info.dart';
import 'package:getx_hacker_news_api/app/presentation/home_bloc/bloc/articles_bloc.dart';
import 'package:getx_hacker_news_api/app/presentation/home_bloc/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

import '../../test_helper.dart';

class MockNetworkInfo extends Mock implements NetworkInfoI {}

class MockGetRemoteArticles extends Mock implements GetRemoteArticles {}

class MockGetLocalArticles extends Mock implements GetLocalArticles {}

void main() {
  NetworkInfoI networkInfo;
  GetRemoteArticles getRemoteArticles;
  GetLocalArticles getLocalArticles;
  ArticlesBloc articlesBloc;

  setUp(() {
    networkInfo = MockNetworkInfo();
    getRemoteArticles = MockGetRemoteArticles();
    getLocalArticles = MockGetLocalArticles();
    articlesBloc = ArticlesBloc();
    Get.lazyPut<NetworkInfoI>(() => networkInfo);
    Get.lazyPut<GetRemoteArticles>(() => getRemoteArticles);
    Get.lazyPut<GetLocalArticles>(() => getLocalArticles);
  });

  test(
      'when add GetData event should yield Loading, check for network info, call get local/remote articles, and yield Success if succesful, else yield Error',
      () async {
    // arrange
    when(networkInfo.isConnected())
        .thenAnswer((realInvocation) => Future.value(true));
    when(getRemoteArticles.call())
        .thenAnswer((realInvocation) => Future.value(Right(articles)));
    // act
    articlesBloc.add(const GetData());

    // assert
    expectLater(articlesBloc,
        emitsInOrder([const Initial(), const Loading(), Success(articles)]));
  });
}
