import 'package:get/get.dart';

import 'package:getx_hacker_news_api/app/modules/loading/loading_controller.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(
      () => LoadingController(),
    );
  }
}
