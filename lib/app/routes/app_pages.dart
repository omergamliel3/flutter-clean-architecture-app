import '../modules/loading/loading_view.dart';
import '../modules/loading/loading_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/home/home_binding.dart';
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
