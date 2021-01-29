import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_hacker_news_api/app/core/usecases/usecase.dart';

import 'package:getx_hacker_news_api/app/domain/usecases/get_local_articles.dart';
import 'package:getx_hacker_news_api/app/domain/usecases/get_remote_articles.dart';

import 'package:getx_hacker_news_api/app/core/network/network_info.dart';
import 'package:getx_hacker_news_api/app/presentation/home_bloc/controller/index.dart';
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
    articlesBloc =
        ArticlesBloc(networkInfo, getRemoteArticles, getLocalArticles);
  });

  group('is online', () {
    blocTest<ArticlesBloc, ArticlesState>(
      'should emits [Loading, Success] when [GetData] event is called succesfuly.',
      build: () {
        when(networkInfo.isConnected())
            .thenAnswer((realInvocation) => Future.value(true));
        when(getRemoteArticles.call(NoParams()))
            .thenAnswer((realInvocation) => Future.value(Right(articles)));
        return articlesBloc;
      },
      act: (bloc) => bloc.add(const GetData()),
      expect: [isA<Loading>(), Success(articles)],
      verify: (_) {
        verifyInOrder(
            [networkInfo.isConnected(), getRemoteArticles.call(NoParams())]);
        verifyNoMoreInteractions(networkInfo);
        verifyNoMoreInteractions(getRemoteArticles);
        verifyZeroInteractions(getLocalArticles);
      },
    );
  });

  group('is offline', () {
    blocTest<ArticlesBloc, ArticlesState>(
      'should emits [Loading, Success] when [GetData] event is called succesfuly.',
      build: () {
        when(networkInfo.isConnected())
            .thenAnswer((realInvocation) => Future.value(false));
        when(networkInfo.onConnectivityChanged).thenAnswer(
            (realInvocation) => Stream.fromIterable([ConnectivityResult.none]));
        when(getLocalArticles.call(NoParams()))
            .thenAnswer((realInvocation) => Future.value(Right(articles)));
        return articlesBloc;
      },
      act: (bloc) => bloc.add(const GetData()),
      expect: [isA<Loading>(), Success(articles)],
      verify: (_) {
        verifyInOrder([
          networkInfo.isConnected(),
          getLocalArticles.call(NoParams()),
          networkInfo.onConnectivityChanged
        ]);
        verifyNoMoreInteractions(networkInfo);
        verifyNoMoreInteractions(getLocalArticles);
        verifyZeroInteractions(getRemoteArticles);
      },
    );
  });
}
