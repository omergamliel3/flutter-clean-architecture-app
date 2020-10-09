import 'package:get/get.dart';

import 'loading_controller.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingController>(LoadingController());
  }
}
