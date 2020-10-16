import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// launch call via url launcher
Future launch(String url) async {
  if (await url_launcher.canLaunch(url)) {
    url_launcher.launch(url);
  } else {
    Get.snackbar('Ooops...', 'Can not launch url');
  }
}
