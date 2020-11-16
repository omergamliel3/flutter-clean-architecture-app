import '../presentation/index.dart';

import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeViewCubit(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
