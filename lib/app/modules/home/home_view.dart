import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/core/utils/launcher.dart';
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
            'NewsAPI',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ).paddingAll(4.0),
      actions: [connectivityIcon().paddingOnly(right: 10.0)],
    );
  }

  Widget connectivityIcon() {
    return Obx(() {
      switch (controller.connectvityResult.value) {
        case ConnectivityResult.none:
          return Icon(
            Icons.signal_wifi_off,
            color: Colors.black,
          );
          break;
        case ConnectivityResult.mobile:
          return Icon(
            Icons.network_cell,
            color: Colors.black,
          );
        case ConnectivityResult.wifi:
          return Icon(
            Icons.wifi,
            color: Colors.black,
          );
        default:
          return Container();
      }
    });
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
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );
  }

  Widget busyWidget() {
    return Center(
      child: CircularProgressIndicator(
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
            var article = controller.articles[index];
            return InkWell(
              onTap: () => launch(article.url),
              child: Container(
                width: Get.mediaQuery.size.width,
                child: Card(
                  elevation: 4.0,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0)),
                          child: Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                            height: Get.mediaQuery.size.height * 0.3,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                'CANT LOAD IMAGE :(',
                                style: Theme.of(context).textTheme.headline2,
                              );
                            },
                          )),
                      Text(
                        article.title ?? '',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ).paddingAll(4.0),
                      Text(
                        article.content ?? '',
                        style: TextStyle(fontSize: 18),
                      ).paddingAll(4.0),
                    ],
                  )),
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
    return SafeArea(
      top: false,
      child: Scaffold(
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
      ),
    );
  }
}
