import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/routes/app_pages.dart';

class LoadingController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offAndToNamed(Routes.HOME);
  }

  final size = 5.obs;

  @override
  void onReady() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (size.value <= 80) {
        size.value++;
      }
    });
  }

  @override
  void onClose() {
    size.close();
  }
}
