import 'package:community_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  PageController? pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(viewportFraction: 1);
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }

  void navigateToNextPage() {
    if (pageController!.page != 2) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Get.offAndToNamed(ROUTE_LANGUAGE_PAGE);
    }
  }
}
