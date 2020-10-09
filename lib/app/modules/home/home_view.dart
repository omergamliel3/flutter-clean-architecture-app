import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/core/assets/constans.dart';
import 'package:getx_hacker_news_api/app/core/utils/launcher.dart';
import 'package:getx_hacker_news_api/app/core/widgets/error_widget.dart'
    as errorWidget;
import 'package:getx_hacker_news_api/app/core/widgets/keep_alive_wrapper.dart';
import 'package:getx_hacker_news_api/app/core/widgets/loading_widget.dart';
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
          const Icon(
            Icons.adb,
            color: Colors.black,
          ),
          const SizedBox(
            width: 6.0,
          ),
          const Text(
            'NewsReader',
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
          return const Icon(
            Icons.signal_wifi_off,
            color: Colors.black,
          );
          break;
        case ConnectivityResult.mobile:
          return const Icon(
            Icons.network_cell,
            color: Colors.black,
          );
        case ConnectivityResult.wifi:
          return const Icon(
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
        onPressed: () => controller.remoteFetch(),
        backgroundColor: Colors.amber,
        icon: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
        label: const Text(
          'REFRESH',
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget dataWidget() {
    if (controller.articles.length == 0) {
      const Center(
        child: Text(
          'Cant find articles at this moment :(',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.remoteFetch();
        },
        child: ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            var article = controller.articles[index];
            return GestureDetector(
              onTap: () => launch(article.url),
              child: Container(
                width: Get.mediaQuery.size.width,
                child: Card(
                  elevation: 4.0,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      article.urlToImage != null
                          ? buildImage(article.urlToImage)
                          : buildAssetImage(),
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

  Widget buildImage(String url) {
    return KeepAliveWrapper(
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          child: FadeInImage.assetNetwork(
            height: Get.mediaQuery.size.height * 0.3,
            width: double.infinity,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: loadingAsset,
            image: url,
            imageErrorBuilder: (context, obj, error) => buildAssetImage(),
          )),
    );
  }

  Widget buildAssetImage() {
    return Image.asset(
      placeholderAsset,
      height: Get.mediaQuery.size.height * 0.3,
      width: double.infinity,
      fit: BoxFit.cover,
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
              return LoadingWidget();
              break;
            case ViewState.error:
              return errorWidget.ErrorWidget();
            case ViewState.data:
              return dataWidget();
            default:
              return LoadingWidget();
          }
        }),
        floatingActionButton: floatingActionButton(),
      ),
    );
  }
}
