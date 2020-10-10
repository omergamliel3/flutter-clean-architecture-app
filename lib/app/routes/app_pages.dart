import '../presentation/home_bloc/view/articles_page_view.dart';
import '../presentation/index.dart';

import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final routes = [
    ///! GetX state managment
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => HomeView(),
    //   binding: HomeBinding(),
    // ),
    /// ! Bloc state managment, only use if registered ArticlesBloc in injector
    GetPage(
      name: Routes.HOME,
      page: () => ArticlesPageView(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
