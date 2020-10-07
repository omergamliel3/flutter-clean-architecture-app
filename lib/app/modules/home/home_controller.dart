import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_hacker_news_api/app/services/api.dart';

enum ViewState { initial, busy, error, data }

class HomeController extends GetxController {
  // api service
  final api = Get.find<Api>();

  // view state
  final viewState = ViewState.initial.obs;

  // articles data
  List<String> _articles;
  // articles getter
  List<String> get articles => List.from(_articles);

  // call fetch when init controller
  @override
  void onInit() async {
    fetch();
  }

  // feth data from api service
  Future<void> fetch() async {
    _setState(ViewState.busy);
    var result = await api.fetchArticles();
    _handleFetchResult(result);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<String>> result) {
    result.fold((feilure) {
      _articles?.clear();
      _setState(ViewState.error);
      Get.snackbar('Loaded failed!', 'error: $feilure',
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
