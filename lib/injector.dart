import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'app/presentation/home_bloc/bloc/bloc.dart';

import 'app/core/network/network_info.dart';

import 'app/data/datasources/articles_local_datasource.dart';
import 'app/data/datasources/articles_remote_datasource.dart';

import 'app/data/repositories/articles_repository_impl.dart';
import 'app/domain/repositories/articles_repository.dart';

import 'app/domain/usecases/get_local_articles.dart';
import 'app/domain/usecases/get_remote_articles.dart';

// inject app dependencies
Future<void> injectDependencies() async {
  ///! HomeViewBloc dependency. comment if you are using HomeViewGetX
  Get.lazyPut<ArticlesBloc>(() => ArticlesBloc(const Initial()));

  // Data sources
  Get.lazyPut<ArticlesRemoteDatasource>(
      () => ArticlesRemoteDatasource(client: http.Client()));
  Get.putAsync(() async {
    final service = ArticlesLocalDatasource();
    await service.initDb();
    return service;
  });

  // Use cases
  Get.lazyPut<GetLocalArticles>(
      () => GetLocalArticles(Get.find<ArticlesRepository>()));
  Get.lazyPut<GetRemoteArticles>(
      () => GetRemoteArticles(Get.find<ArticlesRepository>()));

  // Repository
  Get.lazyPut<ArticlesRepository>(() => ArticlesRepositoryImpl(
      localDataSource: Get.find<ArticlesLocalDatasource>(),
      remoteDataSource: Get.find<ArticlesRemoteDatasource>()));

  // Core
  Get.lazyPut(() => NetworkInfo(connectivity: Connectivity()));
}
