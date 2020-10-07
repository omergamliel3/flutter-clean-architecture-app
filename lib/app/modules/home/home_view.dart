import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  Widget appBar() {
    return AppBar(
        elevation: 8.0,
        backgroundColor: Colors.yellow,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.adb,
              color: Colors.black,
            ),
            SizedBox(
              width: 6.0,
            ),
            Text(
              'HackerNewsAPI',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ).paddingAll(4.0));
  }

  Widget floatingActionButton() {
    return FloatingActionButton.extended(
        onPressed: () => controller.fetch(),
        backgroundColor: Colors.amber,
        icon: Icon(
          Icons.refresh,
          color: Colors.black,
        ),
        label: Text(
          'REFRESH',
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget initialWidget() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget busyWidget() {
    return Center(
      child: CircularProgressIndicator(
        //backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget errorWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        // SizedBox(height: 10.0),
        // RaisedButton(
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        //   color: Colors.amber,
        //   onPressed: () => controller.fetch(),
        //   child: Text('Refresh'),
        // )
      ],
    ));
  }

  Widget dataWidget() {
    if (controller.articles.length == 0) {
      Center(
        child: Text(
          'Cant find articles at this moment :(',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetch();
        },
        child: ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            return Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height * 0.3,
              child: Card(
                elevation: 4.0,
                child: Center(
                  child: Text(
                    controller.articles[index],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: appBar(),
      body: Obx(() {
        switch (controller.viewState.value) {
          case ViewState.busy:
            return busyWidget();
            break;
          case ViewState.error:
            return errorWidget();
          case ViewState.data:
            return dataWidget();
          default:
            return initialWidget();
        }
      }),
      floatingActionButton: floatingActionButton(),
    );
  }
}
