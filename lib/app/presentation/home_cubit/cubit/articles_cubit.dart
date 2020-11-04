import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_local_articles.dart';
import '../../../domain/usecases/get_remote_articles.dart';

import 'package:getx_hacker_news_api/app/core/errors/failure.dart';
import 'package:getx_hacker_news_api/app/core/network/network_info.dart';

import 'article_state/state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  // construct bloc with initial state
  ArticlesCubit(this.network, this.getRemoteArticles, this.getLocalArticles)
      : super(const Initial());

  // get dependencies
  final NetworkInfoI network;
  final GetRemoteArticles getRemoteArticles;
  final GetLocalArticles getLocalArticles;

  Future<void> getArticles() async {
    emit(const Loading());
    final connectivity = await network.isConnected();
    Either<Failure, List<Article>> failureOrArticles;
    if (connectivity) {
      failureOrArticles = await getRemoteArticles.call();
    } else {
      failureOrArticles = await getLocalArticles.call();
      waitForConnectivityAndCallGetArticles();
      Get.snackbar('Offline mode', 'There is no internet connection',
          snackPosition: SnackPosition.BOTTOM);
    }
    emit(failureOrArticles.fold(
        (failure) => Error(failure), (articles) => Success(articles)));
  }

  void waitForConnectivityAndCallGetArticles() {
    StreamSubscription subscription;
    subscription = network.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        subscription.cancel();
        getArticles();
      }
    });
  }
}
