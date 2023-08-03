import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:get/get.dart';

class NoInternetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoInternetController>(() => NoInternetController());
  }
}
