import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/modules/loading/loading_controller.dart';
import 'package:getx_hacker_news_api/app/routes/app_pages.dart';

class LoadingView extends GetView<LoadingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LoadingView'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'LoadingView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 15),
            Obx(() =>
                Center(child: Text('Obx: ${controller.count1.toString()}'))),
            SizedBox(height: 15),
            GetBuilder<LoadingController>(
                id: 'test_builder',
                builder: (controller) => Center(
                    child:
                        Text('GetBuilder: ${controller.count2.toString()}'))),
            SizedBox(height: 15),
            RaisedButton(
              child: Text('GO TO HOME PAGE'),
              onPressed: () => Get.toNamed(Routes.HOME,
                  arguments: {'name': 'omer', 'age': 21}),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  child: Text('SHOW DIALOG'),
                  onPressed: () => controller.showDialog(),
                ),
                SizedBox(width: 4.0),
                RaisedButton(
                  child: Text('DARK THEME'),
                  onPressed: () => Get.changeThemeMode(ThemeMode.dark),
                ),
                SizedBox(width: 4.0),
                RaisedButton(
                  child: Text('LIGHT THEME'),
                  onPressed: () => Get.changeThemeMode(ThemeMode.light),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'increment1',
              onPressed: () => controller.increment1(),
              child: Icon(Icons.add),
            ),
            SizedBox(width: 6.0),
            FloatingActionButton(
              heroTag: 'increment2',
              onPressed: () => controller.increment2(),
              child: Icon(Icons.add),
            )
          ],
        ));
  }
}
