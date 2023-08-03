// message_controller.dart
import 'dart:async';
import 'dart:developer';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/data/repositories/deshboard_Repository.dart';
import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../notification_page/notification_controller.dart';
import 'model/message_model.dart';

class MessageController extends GetxController {
  DeshboardRepository? deshboardRepository;
  MessageRepository? messageRepository;
  MessageController({this.deshboardRepository, this.messageRepository});
  final TextEditingController searchThreadController = TextEditingController();
  late AuthenticationManager authManager;
  RxList<ThreadData> threads = <ThreadData>[].obs;
  ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxBool isRead = false.obs;
  FocusNode? focusNode;

  @override
  void onInit() {
    authManager = Get.find();
    focusNode = FocusNode();
    getThreadsFunction();
    super.onInit();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getThreadsFunction();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  getThreadsFunction() async {
    isLoading.value = true;
    update();
    await messageRepository?.getThreads().then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          final threadData = jsonData['data'] as List<dynamic>;
          threads.clear();
          threads.addAll(
              threadData.map((data) => ThreadData.fromJson(data)).toList());
          update();
        } else {
          log("Error: ${response.data}");
        }
      }
    });
    isLoading.value = false;
    update();
  }

  Future<void> getThreadByNameFunction(String name) async {
    threads.clear();
    isLoading.value = true;
    update();
    await messageRepository
        ?.getThreadByName(searchThreadController.text)
        .then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          final threadData = jsonData['data'] as List<dynamic>;
          if (threadData.isNotEmpty) {
            threads.addAll(
                threadData.map((data) => ThreadData.fromJson(data)).toList());
            update();
          } else {
            getSnackBar(Tkey.noThreadFound.tr, SNACK.FAILURE);
            update();
          }
          update();
        } else {
          log("Error: ${response.data}");
        }
      }
    });
    isLoading.value = false;
    update();
  }

  Future<void> notificationFunction() async {
    if (Get.isRegistered<NotificationController>()) {
      final notificationController = Get.find<NotificationController>();
      await notificationController.getNotification().then((value) {
        print(value.toString());
        isRead.value = value;
        notificationController.update();
      });
    }
  }

  @override
  void dispose() {
    searchThreadController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
