import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/core/models/article.dart';
import 'package:getx_hacker_news_api/app/core/models/failure.dart';
import 'package:getx_hacker_news_api/app/services/articles_service.dart';

enum ViewState { initial, busy, error, data }

class HomeController extends GetxController {
  // api service
  final service = Get.find<ArticlesService>();
  final connectivity = Get.find<Connectivity>();
  // view state
  final viewState = ViewState.initial.obs;
  // device connectivity state
  final connectvityResult = ConnectivityResult.none.obs;

  // articles data
  List<Article> _articles;
  // articles getter
  List<Article> get articles => List.from(_articles);

  @override
  void onInit() async {
    // check for connectivity
    connectvityResult.value = await connectivity.checkConnectivity();
    // listen to connectivity changed event and update connectvityResult value
    connectivity.onConnectivityChanged.listen((event) {
      connectvityResult.value = event;
      if (event != ConnectivityResult.none &&
          (_articles == null || _articles.isEmpty)) fetch();
    });
    if (connectvityResult.value == ConnectivityResult.none) {
      // implement no connectivity data (fetch saved data from local db)
      print('no connectivity!');
      _setState(ViewState.error);
    } else {
      fetch();
    }
  }

  @override
  void onClose() {
    viewState.close();
    connectvityResult.close();
  }

  // feth data from api service
  Future<void> fetch() async {
    if (viewState.value == ViewState.busy) return;
    _setState(ViewState.busy);
    var result = await service.fetchArticles();
    _handleFetchResult(result);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<Article>> result) {
    result.fold((feilure) {
      _articles?.clear();
      _setState(ViewState.error);
      Get.snackbar('Loaded failed!', '$feilure',
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
      _articles = data;
      _setState(ViewState.data);
      Get.snackbar('Loaded successfuly!',
          ' ${_articles.length} new articles ready for reading',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set viewstate
  void _setState(ViewState state) {
    viewState.value = state;
  }
}
