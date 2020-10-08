import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/core/models/article.dart';
import 'package:getx_hacker_news_api/app/core/models/failure.dart';
import 'package:getx_hacker_news_api/app/services/articles_service.dart';

enum ViewState { initial, busy, error, data }

class HomeController extends GetxController {
  // articles service
  final service = Get.find<ArticlesService>();
  final connectivity = Get.find<Connectivity>();
  // view state reactive value
  final viewState = ViewState.initial.obs;
  // device connectivity state reactive value
  final connectvityResult = ConnectivityResult.none.obs;

  // articles data
  List<Article> _articles;
  // articles getter
  List<Article> get articles => List.from(_articles);
  // track local/remote articles state in view
  bool localArticlesView = false;

  @override
  void onInit() async {
    // check for connectivity
    connectvityResult.value = await connectivity.checkConnectivity();

    if (connectvityResult.value == ConnectivityResult.none) {
      localFetch();
    } else {
      remoteFetch();
    }

    // listen to connectivity changed event and update connectvityResult value
    connectivity.onConnectivityChanged.listen((event) {
      connectvityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and articles data is empty, null or in local view
      if (event != ConnectivityResult.none &&
          (_articles == null || _articles.isEmpty || localArticlesView))
        remoteFetch();
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
    var result = await service.fetchArticles();
    _handleFetchResult(result);
  }

  // feth data from local database
  Future<void> localFetch() async {
    localArticlesView = true;
    if (viewState.value == ViewState.busy) return;
    _setState(ViewState.busy);
    var result = await service.fetchLocalSavedArticles();
    _handleFetchResult(result, true);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<Article>> result,
      [bool local = false]) {
    result.fold((feilure) {
      _articles?.clear();
      _setState(ViewState.error);
      Get.snackbar('Loaded failed!', '$feilure',
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
      _articles = data;
      _setState(ViewState.data);
      var notifyLocal = local ? '(offline mode)' : '';
      Get.snackbar('Loaded successfuly!',
          ' ${_articles.length} new articles ready for reading $notifyLocal',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set viewstate
  void _setState(ViewState state) {
    viewState.value = state;
  }
}
