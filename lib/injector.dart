import 'package:kiwi/kiwi.dart';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'app/data/api/api.dart';
import 'app/data/datasources/local/articles_local_datasource.dart';
import 'app/data/datasources/remote/articles_remote_datasource.dart';

import 'app/data/datasources/local/hive/articles_local_datasource_hive.dart';

import 'app/data/repositories/articles_repository_impl.dart';
import 'app/domain/repositories/articles_repository.dart';

import 'app/domain/usecases/get_local_articles.dart';
import 'app/domain/usecases/get_remote_articles.dart';

import 'app/core/network/network_info.dart';

import 'app/presentation/home_cubit/cubit/articles_cubit.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureCore();
    _configureArticlesFeatureModule();
  }

  // Core module
  @Register.singleton(Connectivity)
  @Register.singleton(NetworkInfoI, from: NetworkInfo)
  void _configureCore();

  // Articles Feature module
  void _configureArticlesFeatureModule() {
    _configureArticlesFeatureModuleInstances();
    _configureArticlesFeatureModuleFactories();
  }

  // Articles Feature module instances
  void _configureArticlesFeatureModuleInstances() {
    container.registerInstance(
        RestClient(Dio(BaseOptions(contentType: "application/json"))));
  }

  // Articles Feature module factories
  @Register.factory(ArticlesRemoteDatasource)
  @Register.factory(ArticlesLocalDatasource,
      from: ArticlesLocalDatasourceHiveImpl)
  @Register.factory(GetLocalArticles)
  @Register.factory(GetRemoteArticles)
  @Register.factory(ArticlesRepository, from: ArticlesRepositoryImpl)
  @Register.factory(ArticlesCubit)
  void _configureArticlesFeatureModuleFactories();
}
