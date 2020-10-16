import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

import '../../core/widgets/index.dart' as core_widgets;
import 'widgets/widgets.dart';

class HomeViewGetX extends GetView<HomeController> {
  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 8.0,
      backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.adb,
            color: Colors.black,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            'NewsReader',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ).paddingAll(4.0),
      actions: [
        ConnectivityIcon(controller: controller).paddingOnly(right: 10.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: appBar(),
        body: Obx(() {
          switch (controller.viewState.value) {
            case ViewState.busy:
              return core_widgets.LoadingWidget();
              break;
            case ViewState.error:
              return const core_widgets.ErrorWidget();
            case ViewState.data:
              return ArticlesView(
                articles: controller.articles,
                fetch: controller.remoteFetch,
              );
            default:
              return core_widgets.LoadingWidget();
          }
        }),
        floatingActionButton: FAB(
          callback: controller.remoteFetch,
        ),
      ),
    );
  }
}
