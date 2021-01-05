// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureCore() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => Connectivity());
    container.registerSingleton<NetworkInfoI>(
        (c) => NetworkInfo(connectivity: c<Connectivity>()));
  }

  @override
  void _configureArticlesFeatureModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => ArticlesRemoteDatasource(client: c<RestClient>()));
    container.registerFactory<ArticlesLocalDatasource>(
        (c) => ArticlesLocalDatasourceHiveImpl());
    container.registerFactory((c) => GetLocalArticles(c<ArticlesRepository>()));
    container
        .registerFactory((c) => GetRemoteArticles(c<ArticlesRepository>()));
    container.registerFactory<ArticlesRepository>((c) => ArticlesRepositoryImpl(
        localDataSource: c<ArticlesLocalDatasource>(),
        remoteDataSource: c<ArticlesRemoteDatasource>()));
    container.registerFactory((c) => ArticlesCubit(
        c<NetworkInfoI>(), c<GetRemoteArticles>(), c<GetLocalArticles>()));
  }
}
