import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/modules/loading/loading_controller.dart';

class LoadingView extends GetView<LoadingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Obx(() {
              return Icon(
                Icons.adb,
                size: controller.size.value.toDouble(),
                color: Colors.black,
              );
            }),
          ).paddingOnly(top: Get.mediaQuery.size.height * 0.4),
          Spacer(),
          Text(
            'LOADING...',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ).paddingOnly(bottom: 20.0)
        ],
      ),
    );
  }
}
