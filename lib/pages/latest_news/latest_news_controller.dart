import 'dart:async';
import 'dart:developer';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/pages/home_page/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../translation/key.dart';
import '../../widget/custom_alert_dialogue.dart';
import 'model/news_model.dart';

class LatestNewsController extends GetxController {
  final NewsRepository? newsRepository;
  LatestNewsController({this.newsRepository});
  List<News> newsList = <News>[];
  TextEditingController searchNewsController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currPage = 1;
  RxBool isLoading = false.obs;
  RxBool nextPage = false.obs;
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    getFirstPageNewsFunction();
    super.onInit();
  }

  @override
  void dispose() {
    searchNewsController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getFirstPageNewsFunction();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  Future<bool> getNewsFunction() async {
    if (isLoading.value) return false;
    isLoading.value = true;
    update();
    try {
      await newsRepository
          ?.getNews(param: {"page": currPage.toString()}).then((response) {
        if (response != null) {
          if (response.statusCode == 200) {
            NewsModel newsModel = NewsModel.fromJson(response.data);
            newsData = newsModel.results;
            if (newsModel.next != null) {
              currPage++;
              update();
            }
            newsList.addAll(newsData ?? []);
            update();
          } else {}
        }
      });
    } catch (e) {
      log("e$e");
    }
    isLoading.value = false;
    update();
    return nextPage.value;
  }

  NewsModel? newsModel;
  List<News>? newsData = [];
  Future<void> getFirstPageNewsFunction() async {
    newsList.clear();
    isLoading.value = true;
    update();
    await newsRepository?.getNews(param: {"page": 1}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          newsModel = NewsModel.fromJson(response.data);
          newsData = newsModel?.results;
          if (newsModel?.next != null) {
            currPage++;
            update();
          }
          newsList.addAll(newsData ?? []);
          if (Get.isRegistered<HomePageController>()) {
            final controller = Get.find<HomePageController>();
            controller.getNewsFunction();
            controller.update();
          }
          update();
        } else {}
      }
    });
    isLoading.value = false;
    update();
  }

  Future<void> searchNewsFunction() async {
    newsList.clear();
    newsRepository?.searchNews(searchNewsController.text).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          newsModel = NewsModel.fromJson(response.data);
          newsData = newsModel?.results;
          newsList.addAll(newsData ?? []);
          update();
        } else {}
      }
    });
  }

  Future<bool> reportNewsFunction(News news, context) async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
              title: Text(
                Tkey.report.tr,
                textAlign: TextAlign.center,
              ),
              content: Text(
                Tkey.areYouSureYouWantToReport.tr,
                textAlign: TextAlign.center,
              ),
              onPressedNo: () {
                Get.back();
                completer.complete(false);
              },
              onPressedYes: () {
                newsRepository?.reportNews(news.id!).then((response) {
                  if (response != null) {
                    if (response.statusCode == 200) {
                      if (Get.isRegistered<HomePageController>()) {
                        final controller = Get.find<HomePageController>();
                        controller.getNewsFunction();
                        controller.update();
                      }
                      getFirstPageNewsFunction();

                      getSnackBar(
                          Tkey.newsReportedSuccessfully.tr, SNACK.SUCCESS);
                      update();
                    }
                  }
                });
                Get.back();
                update();
              },
            ));

    return completer.future;
  }
}
