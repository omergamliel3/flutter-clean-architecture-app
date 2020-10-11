import '../presentation/home_bloc/view/home_view.dart';
import '../presentation/index.dart';

import 'package:get/get.dart';
part 'app_routes.dart';

/// ! note: you can change between HomeViewBloc, and HomeViewGetx.
/// ! Those are same implementation with different state managment

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final routes = [
    /// ! Bloc state managment, only use if registered ArticlesBloc in injector
    GetPage(
      name: Routes.HOME,
      page: () => HomeViewBloc(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}

///! GetX state managment option, replace with HomeViewBloc
// GetPage(
//   name: Routes.HOME,
//   page: () => HomeViewGetX(),
//   binding: HomeBinding(),
// ),
