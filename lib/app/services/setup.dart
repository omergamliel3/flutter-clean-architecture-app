import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/services/api.dart';

// setup services (dependencies) via Get service locator
void setupDependencies() {
  Get.lazyPut(() => Api());
}
