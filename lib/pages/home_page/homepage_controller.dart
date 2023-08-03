import 'dart:async';
import 'dart:developer';

import 'package:community_app/constants/functions.dart';
import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/translation/key.dart';
import 'package:get/get.dart';
import '../../data/repositories/events_repository.dart';
import '../latest_events/model/events_model.dart';
import '../latest_news/model/news_model.dart';
import '../notification_page/notification_controller.dart';

class HomePageController extends GetxController {
  final NewsRepository? newsRepository;
  final EventsRepository? eventsRepository;
  HomePageController({this.newsRepository, this.eventsRepository});
  RxInt pageSizeNews = 10.obs;
  RxInt pageSizeEvents = 10.obs;
  List<News> newsList = <News>[];
  RxList<Events> latestEventsList = <Events>[].obs;
  // late AuthenticationManager authManager;
  RxBool isLoading = false.obs;
  RxBool isRead = false.obs;

  @override
  void onInit() {
    // authManager = Get.find();
    getNewsFunction();
    getEventsFunction();
    super.onInit();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getEventsFunction();
    getNewsFunction();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  List<News>? newsData = [];
  Future<void> getNewsFunction() async {
    isLoading.value = true;
    update();
    newsRepository?.getNews().then(
      (response) {
        if (response != null) {
          isLoading.value = false;
          update();
          if (response.statusCode == 200) {
            NewsModel newsModel = NewsModel.fromJson(response.data);
            newsData = newsModel.results;
            log("[1]newsData::::::$newsModel");
            newsList.addAll(newsData ?? []);
            update();
          } else {
            isLoading.value = false;
            update();
            getSnackBar(response.data['message'], SNACK.FAILURE);
          }
        } else {
          isLoading.value = false;
          update();
          getSnackBar(
              Tkey.somethingwentwrongpleaseagainlater.tr, SNACK.FAILURE);
        }
      },
    );
  }

  Future<void> getEventsFunction() async {
    isLoading.value = true;
    update();
    eventsRepository?.getEvents().then(
      (response) {
        if (response != null) {
          isLoading.value = false;
          update();
          if (response.statusCode == 200) {
            final jsonData = response.data;
            pageSizeEvents.value = jsonData['page_size'];
            final eventsData =
                jsonData['results']['latest_events'] as List<dynamic>;
            latestEventsList.value =
                eventsData.map((data) => Events.fromJson(data)).toList();
            update();
          } else {
            isLoading.value = false;
            update();
          }
        } else {
          isLoading.value = false;
          getSnackBar(
              Tkey.somethingwentwrongpleaseagainlater.tr, SNACK.FAILURE);
          update();
        }
      },
    );
  }

  Future<void> notificationFunction() async {
    if (Get.isRegistered<NotificationController>()) {
      final notificationController = Get.find<NotificationController>();
      await notificationController.getNotification().then(
        (value) {
          print(value.toString());
          isRead.value = value;
          notificationController.update();
        },
      );
    }
  }
}
