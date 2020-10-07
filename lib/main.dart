import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/setup.dart';

void main() {
  setupDependencies();
  runApp(
    GetMaterialApp(
      title: "HackerNews",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    ),
  );
}
