import 'package:getx_hacker_news_api/app/modules/loading/loading_view.dart';
import 'package:getx_hacker_news_api/app/modules/loading/loading_binding.dart';
import 'package:getx_hacker_news_api/app/modules/home/home_view.dart';
import 'package:getx_hacker_news_api/app/modules/home/home_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
