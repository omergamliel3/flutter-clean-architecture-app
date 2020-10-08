import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/setup.dart';

Future<void> main() async {
  await setupDependencies();
  runApp(
    GetMaterialApp(
      title: "NewsAPI",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    ),
  );
}
