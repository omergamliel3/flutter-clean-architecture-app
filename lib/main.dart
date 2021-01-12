import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/theme/theme_data.dart';

import 'app/routes/app_pages.dart';
import 'di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.topLevel,
      title: "NewsReader",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      themeMode: ThemeMode.system,
    ),
  );
}
