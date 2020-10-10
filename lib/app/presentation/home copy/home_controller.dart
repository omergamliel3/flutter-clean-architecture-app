import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../domain/usecases/get_local_articles.dart';
import '../../domain/usecases/get_remote_articles.dart';
import '../../domain/entities/article.dart';

import '../../core/network/network_info.dart';
import '../../core/errors/failure.dart';

enum ViewState { initial, busy, error, data }

class HomeController extends GetxController {
  // network info
  final network = Get.find<NetworkInfo>();
  final getRemoteArticles = Get.find<GetRemoteArticles>();
  final getLocalArticles = Get.find<GetLocalArticles>();
  // view state reactive value
  final viewState = ViewState.initial.obs;
  // device connectivity state reactive value
  final connectvityResult = ConnectivityResult.none.obs;
  // view state history
  final historyViewState = <ViewState>[];

  // articles data
  List<Article> _articles;
  // articles getter
  List<Article> get articles => List.from(_articles);
  // track local/remote articles state in view
  bool localArticlesView = false;

  @override
  void onInit() async {
    // check for connectivity
    connectvityResult.value = await network.connectivityResult;

    if (connectvityResult.value == ConnectivityResult.none) {
      localFetch();
    } else {
      remoteFetch();
    }

    // listen to connectivity changed event and update connectvityResult value
    network.onConnectivityChanged.listen((event) {
      connectvityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and articles data is empty, null or in local view
      if (event != ConnectivityResult.none &&
          (_articles == null || _articles.isEmpty || localArticlesView)) {
        remoteFetch();
      }
    });
  }

  @override
  void onClose() {
    // close subscriptions for rx values
    viewState.close();
    connectvityResult.close();
  }

  // feth data from articles service
  Future<void> remoteFetch() async {
    localArticlesView = false;
    if (viewState.value == ViewState.busy) return;
    if (connectvityResult.value == ConnectivityResult.none) {
      Get.snackbar('Can\'t refresh when offline',
          'Please connect your device to wifi or mobile network',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _setState(ViewState.busy);
    var result = await getRemoteArticles.call();
    _handleFetchResult(result);
  }

  // feth data from local database
  Future<void> localFetch() async {
    localArticlesView = true;
    if (viewState.value == ViewState.busy) return;
    _setState(ViewState.busy);
    var result = await getLocalArticles.call();
    _handleFetchResult(result, true);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<Article>> result,
      [bool local = false]) {
    result.fold((feilure) {
      _articles?.clear();
      _setState(ViewState.error);
      Get.snackbar('Refresh failed!', '$feilure',
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
      _articles = data;
      _setState(ViewState.data);
      var notifyLocal = local ? '(offline mode)' : '';
      Get.snackbar('Refresh successfuly!',
          ' ${_articles.length} new articles ready for reading $notifyLocal',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set viewstate
  void _setState(ViewState state) {
    viewState.value = state;
    historyViewState.add(state);
  }
}
