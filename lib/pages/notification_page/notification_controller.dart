import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/deshboard_Repository.dart';
import 'model/notification_model.dart/notification_model.dart';

class NotificationController extends GetxController {
  DeshboardRepository? deshboardRepository;
  NotificationController({this.deshboardRepository});
  RxList<Results> listofnotification = <Results>[].obs;
  int currentPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoading) {
          getNotification();
        }
      }
    });
    getNotification();
    update();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getNotification();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  getNotification() {
    if (!isLoading) {
      isLoading = true;
      deshboardRepository?.getnotification(
        param: {"page": currentPage.toString()},
      ).then((response) {
        if (response != null) {
          if (response.statusCode == 200) {
            Notificationmodel notificationList =
                Notificationmodel.fromJson(response.data);
            listofnotification.addAll(notificationList.results!);
            currentPage++;
            update();
          } else {
            log('response.statusCode: ${response.statusCode}');
          }
        }
        isLoading = false;
        update();
      });
    }
  }

  deletNotification({int? id}) {
    log("id:$id");
    deshboardRepository?.deletenotification(id: id).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          listofnotification
              .removeWhere((notification) => notification.id == id);
          update();
        } else {
          log('response.statusCode: ${response.statusCode}');
        }
      }
      isLoading = false;
      update();
      getNotification();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
