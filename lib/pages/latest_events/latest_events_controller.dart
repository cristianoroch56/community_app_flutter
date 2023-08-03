import 'dart:async';

import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/data/repositories/events_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'model/events_model.dart';

class LatestEventsController extends GetxController {
  EventsRepository? eventsRepository;
  LatestEventsController({this.eventsRepository});
  RxInt pageSize = 10.obs;
  RxInt count = 10.obs;
  RxList<Events> latestEventsList = <Events>[].obs;
  RxList<Events> upcomingEventsList = <Events>[].obs;
  TextEditingController eventSearchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currPage = 1;
  RxBool isLoading = false.obs;
  RxBool nextPage = false.obs;
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    getEventsFunction();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (nextPage.value != false) {
          getEventsFunction();
        }
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    eventSearchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getEventsFunction();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  Future<void> getEventsFunction() async {
    isLoading.value = true;
    update();
    await eventsRepository
        ?.getEvents(param: {"page": currPage.toString()}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          pageSize.value = jsonData['page_size'];
          count.value = jsonData['count'];
          if (jsonData['next'] == null) {
            nextPage.value = false;
            update();
          } else {
            nextPage.value = true;
            update();
          }
          final latesteventsData =
              jsonData['results']['latest_events'] as List<dynamic>;
          latestEventsList.addAll(
              latesteventsData.map((data) => Events.fromJson(data)).toList());
          final upcomingeventsData =
              jsonData['results']['upcoming_events'] as List<dynamic>;
          upcomingEventsList.value =
              upcomingeventsData.map((data) => Events.fromJson(data)).toList();
          currPage++;
          update();
        } else {}
      }
    });
    isLoading.value = false;
    update();
  }

  Future<void> getFirstPageEventsFunction() async {
    isLoading.value = true;
    update();
    await eventsRepository?.getEvents(param: {"page": 1}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          pageSize.value = jsonData['page_size'];
          count.value = jsonData['count'];
          if (jsonData['next'] == null) {
            nextPage.value = false;
            update();
          } else {
            nextPage.value = true;
            update();
          }
          latestEventsList.clear();
          final latesteventsData =
              jsonData['results']['latest_events'] as List<dynamic>;
          latestEventsList.addAll(
              latesteventsData.map((data) => Events.fromJson(data)).toList());
          currPage = 2;
          update();
        } else {}
      }
    });
    isLoading.value = false;
    update();
  }

  Future<void> searchEventsFunction() async {
    eventsRepository?.searchEvents(eventSearchController.text).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          pageSize.value = jsonData['page_size'];
          count.value = jsonData['count'];
          final eventsData = jsonData['results'] as List<dynamic>;
          if (eventsData.isNotEmpty) {
            latestEventsList.value =
                eventsData.map((data) => Events.fromJson(data)).toList();
          } else {
            getSnackBar(Tkey.noEventsFound.tr, SNACK.FAILURE);
          }
          update();
        } else {}
      }
    });
  }
}
