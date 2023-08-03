import 'dart:async';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/data/repositories/deshboard_Repository.dart';
import 'package:community_app/pages/message_page/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../translation/key.dart';
import '../../data/repositories/message_repository.dart';
import '../../routes/app_routes.dart';
import '../auth/authentication_manager.dart';
import '../notification_page/notification_controller.dart';
import 'model/member_model.dart';

class MemberController extends GetxController {
  final DeshboardRepository? deshboardRepository;
  final MessageRepository? messageRepository;
  MemberController({this.deshboardRepository, this.messageRepository});
  late AuthenticationManager authManager;
  final TextEditingController membersController = TextEditingController();
  RxList<MemberData> listofmember = <MemberData>[].obs;
  RxInt count = 10.obs;
  RxBool isRead = false.obs;
  FocusNode? focusNode;
  RxBool isLoading = false.obs;
  RxBool nextPage = false.obs;
  ScrollController scrollController = ScrollController();
  int currPage = 1;
  var isRefreshing = false.obs;

  @override
  void onInit() {
    listofmember.clear();
    authManager = Get.find();
    focusNode = FocusNode();
    getmember();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        if (nextPage.value) {
          getmember();
        }
      }
    });
    super.onInit();
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getmember();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  Membersmodel? membersmodel;
  List<MemberData> memberData = [];
  getmember() {
    isLoading.value = true;
    update();
    deshboardRepository
        ?.getmember(param: {"page": currPage.toString()}).then((response) {
      if (response != null) {
        isLoading.value = false;
        update();
        if (response.statusCode == 200) {
          membersmodel = Membersmodel.fromJson(response.data);
          memberData = membersmodel?.results?.data ?? [];
          listofmember.addAll(memberData);
          if (membersmodel?.next != null) {
            currPage++;
            update();
          }
          update();
        } else {
          isLoading.value = false;
          getSnackBar("", SNACK.FAILURE);
          update();
        }
      } else {
        isLoading.value = false;
        getSnackBar("", SNACK.FAILURE);
        update();
      }
    });
  }

  Future<bool> getMoreMember() async {
    await deshboardRepository
        ?.getmember(param: {"page": currPage.toString()}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          membersmodel = Membersmodel.fromJson(response.data);
          memberData = membersmodel?.results?.data ?? [];
          listofmember.addAll(memberData);
          if (membersmodel?.next != null) {
            currPage++;
            update();
          }
          update();
        } else {
          getSnackBar("", SNACK.FAILURE);
          update();
        }
      } else {
        getSnackBar("", SNACK.FAILURE);
        update();
      }
    });
    return true;
  }

  createThreadFunction(int id) {
    isLoading.value = true;
    update();

    messageRepository?.createThread(jsonData: {"user2": id}).then((response) {
      if (response != null) {
        if (response.statusCode == 201) {
          ThreadData thread = ThreadData.fromJson(response.data);
          Get.toNamed(ROUTE_CHAT_PAGE, arguments: thread);
          update();
        } else {
          isLoading.value = false;
          update();
          getSnackBar("Something went wrong!", SNACK.FAILURE);
        }
      } else {
        isLoading.value = false;
        update();
        getSnackBar(
            "Something went wrong, Please try again later.", SNACK.FAILURE);
      }
    });
  }

  Future<void> searchmembers() async {
    listofmember.clear();
    deshboardRepository?.searchmember(membersController.text).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          membersmodel = Membersmodel.fromJson(response.data);
          memberData = membersmodel?.results?.data ?? [];
          listofmember.addAll(memberData);
          update();
        } else {
          getSnackBar(Tkey.membersnotfind.tr, SNACK.FAILURE);
          update();
        }
      } else {
        update();
        getSnackBar(
            "Something went wrong, Please try again later.", SNACK.FAILURE);
      }
    });
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
    scrollController.dispose();
    super.dispose();
  }
}
