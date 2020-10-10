import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'app/data/datasources/articles_local_datasource.dart';
import 'app/data/datasources/articles_remote_datasource.dart';
import 'app/data/repositories/articles_repository_impl.dart';

// inject app dependencies components
Future<void> injectDependencies() async {
  // construct api
  final api = ArticlesRemoteDatasource(client: Client());
  // construct local db
  final localDatabase = ArticlesLocalDatasource();
  await localDatabase.deleteDB();
  // wait for init database
  await localDatabase.initDb();
  // register ArticlesService
  Get.lazyPut<ArticlesRepositoryImpl>(() => ArticlesRepositoryImpl(
      localDataSource: localDatabase, remoteDataSource: api));
  // register Connectivity service
  Get.lazyPut<Connectivity>(() => Connectivity());
}
