import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/functions.dart';
import '../../data/repositories/account_setting_Repository.dart';
import '../../translation/key.dart';
import 'model/my_members_model.dart';

class MymembersController extends GetxController {
  AccountSettingRepository? accountSettingRepository;
  MymembersController({this.accountSettingRepository});
  final TextEditingController mymemberController = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxList<Data> listofmembers = <Data>[].obs;
  int currentPage = 1;
  RxInt count = 10.obs;
  FocusNode? focusNode;
  RxBool isLoading = false.obs;
  RxBool nextPage = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getmembers();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoading.value) {
          getmembers();
        }
      }
    });
  }

  Future<void> pullToRefresh() async {
    final Completer<void> completer = Completer<void>();
    getmembers();
    completer.complete();
    return completer.future.then<void>(
      (_) {},
    );
  }

  Future<bool> getmembers({bool isRefreshing = false}) async {
    listofmembers.clear();
    if (!isLoading.value) {
      isLoading.value = true;
      accountSettingRepository?.getNewMember(
          param: {"page": currentPage.toString()}).then((response) {
        if (response != null) {
          isLoading.value = false;
          if (response.statusCode == 200) {
            final jsonData = response.data;
            count.value = jsonData['count'];
            if (jsonData['next'] == null) {
              nextPage.value = false;
              update();
            } else {
              isLoading.value = false;
              nextPage.value = true;
              update();
            }
            Mymembersmodel modelList = Mymembersmodel.fromJson(response.data);
            listofmembers.addAll(modelList.results!.data!);
            if (modelList.next != null) {
              currentPage++;
              update();
            }
            update();
          } else {}
        }
      });
    }

    update();
    return nextPage.value;
  }

  Future<void> searchmymembers() async {
    listofmembers.clear();
    update();
    accountSettingRepository
        ?.searchmymember(mymemberController.text)
        .then((response) {
      if (response != null) {
        isLoading.value = false;
        if (response.statusCode == 200) {
          Mymembersmodel modelList = Mymembersmodel.fromJson(response.data);
          listofmembers.addAll(modelList.results!.data!);
          update();
        } else {
          getSnackBar(Tkey.noMemberfoundwiththatname.tr, SNACK.FAILURE);
        }
      }
    });
  }

  @override
  void dispose() {
    mymemberController.dispose();
    scrollController.dispose();
    listofmembers.clear();
    super.dispose();
  }
}
