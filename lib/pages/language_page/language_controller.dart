import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/translation/key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString language = Tkey.selectLanguage.tr.obs;
  final formkey = GlobalKey<FormState>();
  var languages = [Tkey.selectLanguage.tr, "English", "Gujarati"];
  late AuthenticationManager auth;
  @override
  void onInit() {
    auth = Get.find();
    super.onInit();
  }

  void setLanguage(String value) {
    language.value = value;

    if (value == "English") {
      changeLanguage('en_US');
    } else {
      changeLanguage('gu_IN');
    }

    update();
  }

  changeLanguage(String? lanCode) {
    Get.updateLocale(Locale('$lanCode'));
    auth.setLanguage('$lanCode');
  }
}
