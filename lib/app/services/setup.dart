import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../data/local/local_database.dart';
import '../data/network/api.dart';
import 'articles_service.dart';

// setup services (dependencies) via Get service locator
Future<void> setupDependencies() async {
  // construct api
  final api = Api(client: Client());
  // construct local db
  final localDatabase = LocalDatabase();
  // wait for init database
  await localDatabase.initDb();
  // register ArticlesService
  Get.lazyPut<ArticlesService>(
      () => ArticlesService(localDatabase: localDatabase, api: api));
  // register Connectivity service
  Get.lazyPut<Connectivity>(() => Connectivity());
}
