import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'app/core/network/network_info.dart';

import 'app/data/datasources/articles_local_datasource.dart';
import 'app/data/datasources/articles_remote_datasource.dart';

import 'app/data/repositories/articles_repository_impl.dart';
import 'app/domain/repositories/articles_repository.dart';

import 'app/domain/usecases/get_local_articles.dart';
import 'app/domain/usecases/get_remote_articles.dart';

// inject app dependencies components
Future<void> init() async {
  // Data sources
  Get.lazyPut<ArticlesRemoteDatasource>(
      () => ArticlesRemoteDatasource(client: http.Client()));
  Get.lazyPut(() => ArticlesLocalDatasource());
  // Initalise local data source
  await Get.find<ArticlesLocalDatasource>().deleteDB();
  await Get.find<ArticlesLocalDatasource>().initDb();
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
