import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/api_service.dart';
import '../../routes/app_routes.dart';
import '../account_setting_Page/account_setting_page.dart';
import '../home_page/home_page.dart';
import '../message_page/message_page.dart';
import '../member_page/member_page.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;
  late PageStorageBucket pageStorageBucket;
  late Widget currentScreen;
  final Connectivity _connectivity = Connectivity();
  final NoInternetController noInternetController =
      Get.put(NoInternetController());

  @override
  void onInit() {
    pageStorageBucket = PageStorageBucket();
    ApiService().setBaseToken(AuthenticationManager().getToken());
    var data = Get.arguments;
    if (data != null) {
      selectedIndex.value = data;
      currentScreen = Screen[data];
    } else {
      currentScreen = Screen[0];
    }
    update();
    super.onInit();
    _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        Get.offAllNamed(ROUTE_DASHBOARD_PAGE);
        noInternetController.hasInternetConnectivity.value = true;
      } else {
        Get.offAllNamed(ROUTE_NOINTERNET_PAGE);
        noInternetController.hasInternetConnectivity.value = false;
      }
      update();
    });
  }

  // ignore: non_constant_identifier_names
  final Screen = [
    const Homepage(),
    const Memberpage(),
    const Messagepage(),
    const AccountsettingPage()
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
