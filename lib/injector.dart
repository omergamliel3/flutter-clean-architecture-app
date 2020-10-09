import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'app/data/local/local_database.dart';
import 'app/data/network/api.dart';
import 'app/services/articles_service.dart';

// inject app dependencies components
Future<void> injectDependencies() async {
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
