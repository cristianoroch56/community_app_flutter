import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportController extends GetxController {
  AccountSettingRepository? accountSettingRepository;
  HelpAndSupportController({this.accountSettingRepository});
  final formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool loading = false.obs;

  void setLoading(bool value) {
    loading.value = value;
    update();
  }

  Future<void> sendHelpAndSupportFeedback(
      String title, String description) async {
    setLoading(true);
    accountSettingRepository?.postHelpAndSupport(
        jsonData: {"subject": title, "message": description}).then((response) {
      if (response != null) {
        if (response.statusCode == 201) {
          Get.back();
          getSnackBar(Tkey.yourRequestHasBeenSubmitted.tr, SNACK.SUCCESS);
        } else {}
        setLoading(false);
      }
    });
  }
}
