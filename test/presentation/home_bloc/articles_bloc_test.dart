import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

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
    articlesBloc =
        ArticlesBloc(networkInfo, getRemoteArticles, getLocalArticles);
  });

  blocTest<ArticlesBloc, ArticlesState>(
    'should emits [Loading, Success] when [GetData] event is called succesfuly.',
    build: () {
      when(networkInfo.isConnected())
          .thenAnswer((realInvocation) => Future.value(true));
      when(getRemoteArticles.call())
          .thenAnswer((realInvocation) => Future.value(Right(articles)));
      return articlesBloc;
    },
    act: (bloc) => bloc.add(const GetData()),
    expect: [
      isA<Loading>(),
      isA<Success>(),
    ],
    verify: (_) {
      verifyInOrder([networkInfo.isConnected(), getRemoteArticles.call()]);
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(getRemoteArticles);
      verifyZeroInteractions(getLocalArticles);
    },
  );
}
