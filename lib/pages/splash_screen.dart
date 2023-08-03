import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style.dart';
import '../constants/textstyle.dart';

class SplashScreen extends StatelessWidget {
  final AuthenticationManager _authManager = Get.put(AuthenticationManager());
  final NoInternetController noInternetController =
      Get.put(NoInternetController());
  SplashScreen({super.key});
  Future<void> initializeSettings() async {
    _authManager.checkLoginStatus();
    noInternetController.checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationManager>(
      init: AuthenticationManager(),
      initState: (_) {},
      builder: (authController) {
        return SafeArea(
          child: FutureBuilder(
            future: initializeSettings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingView();
              } else {
                if (snapshot.hasError) {
                  return errorView(snapshot);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  Future.delayed(const Duration(seconds: 2), () {
                    authController.isLogged.value
                        ? noInternetController.hasInternetConnectivity.value
                            ? Get.offAndToNamed(ROUTE_DASHBOARD_PAGE)
                            : Get.offAndToNamed(ROUTE_NOINTERNET_PAGE)
                        : Get.offAndToNamed(ROUTE_ONBOARDING_PAGE);
                  });
                }
              }
              return splashView();
            },
          ),
        );
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
          Text(Tkey.loading.tr),
        ],
      ),
    ));
  }

  Widget splashView() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: hp(100),
            child: Column(
              children: [
                Image.asset('assets/icons/2x/top_background_light.png'),
                SizedBox(
                    height: hp(20),
                    child: Image.asset('assets/icons/1.5x/app_logo.png')),
                Text(Tkey.appName.tr,
                    style: textsplashscreenStyle.copyWith(
                        color: secondaryColor3, fontSize: 22))
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: wp(100),
              height: hp(70),
              child: Image.asset('assets/icons/3x/people_vector.png',
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
