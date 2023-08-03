import 'dart:developer';

import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/home_page/homepage_controller.dart';
import 'package:community_app/pages/latest_news/latest_news_controller.dart';
import 'package:get/get.dart';
import '../../data/repositories/news_repository.dart';
import '../latest_news/model/news_model.dart';

class NewsDetailsController extends GetxController {
  final NewsRepository? newsRepository;
  NewsDetailsController({this.newsRepository});
  News? news;

  RxBool isReprtedNews = false.obs;
  @override
  void onInit() {
    news = Get.arguments;
    isReprtedNews.value = news?.isReported ?? false;
    super.onInit();
  }

  reportNewsDetailsFunction(int? id) {
    newsRepository?.reportNews(id).then((response) {
      if (response != null) {
        log("response:$response");
        if (response.statusCode == 200) {
          if (Get.isRegistered<HomePageController>()) {
            final controller = Get.find<HomePageController>();
            controller.getNewsFunction();
            controller.update();
          }
          if (Get.isRegistered<LatestNewsController>()) {
            final controller = Get.find<LatestNewsController>();
            controller.getFirstPageNewsFunction();
            controller.update();
          }
          isReprtedNews.value = true;
          getSnackBar(Tkey.newsReportedSuccessfully.tr, SNACK.SUCCESS);
          update();
        }
      }
    });
    // if (Get.isRegistered<LatestNewsController>()) {
    //   final latestNewsController = Get.find<LatestNewsController>();
    //   await latestNewsController
    //       .reportNewsFunction(news, context)
    //       .then((value) {
    //     print(value.toString());
    //     isReprtedNews.value = value;
    //     latestNewsController.update();
    //   });
    // }
  }
}
