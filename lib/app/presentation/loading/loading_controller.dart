import 'dart:async';

import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class LoadingController extends GetxController {
  @override
  Future onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAndToNamed(Routes.HOME);
  }
}
