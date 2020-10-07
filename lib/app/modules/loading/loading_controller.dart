import 'package:get/get.dart';

class LoadingController extends GetxController {
  final count1 = 0.obs;
  var count2 = 0;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment1() => count1.value++;
  increment2() {
    count2++;
    update(['test_builder']);
  }

  showDialog() {
    Get.defaultDialog(
        radius: 8.0,
        title: 'Default Dialog!',
        textConfirm: 'OK',
        middleText: 'Some test...',
        textCancel: 'BACK');
  }
}
