import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/data/local_database.dart';
import 'package:getx_hacker_news_api/app/services/articles_service.dart';

// setup services (dependencies) via Get service locator
Future<void> setupDependencies() async {
  // construct local database
  final localDatabase = LocalDatabase();
  // wait for local database initalise
  await localDatabase.initDb();
  // register ArticlesService
  Get.lazyPut<ArticlesService>(
      () => ArticlesService(localDatabase: localDatabase));
  // register Connectivity service
  Get.lazyPut<Connectivity>(() => Connectivity());
}
