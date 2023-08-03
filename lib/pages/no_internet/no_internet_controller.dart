import 'package:community_app/constants/functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NoInternetController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasInternetConnectivity = false.obs;

  Future<void> checkInternetConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      hasInternetConnectivity.value = false;
      getSnackBar("No Internet Connection Found!!", SNACK.FAILURE);
      update();
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      hasInternetConnectivity.value = true;
      update();
    }
    // else {
    //   hasInternetConnectivity.value = true;
    //   update();
    // }
    update();
  }
}
