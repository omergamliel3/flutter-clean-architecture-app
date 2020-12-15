import 'dart:async';

import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/data/datasources/local/articles_local_datasource.dart';
import '../../routes/app_pages.dart';

import '../../../injector.dart';

class LoadingController extends GetxController {
  @override
  Future onInit() async {
    await Injector.resolve<ArticlesLocalDatasource>().initDb();
    await Future.delayed(const Duration(seconds: 1));
    Get.offAndToNamed(Routes.HOME);
  }
}
