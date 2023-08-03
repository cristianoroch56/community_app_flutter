import 'dart:developer';

import 'package:community_app/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../translation/key.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../authentication_manager.dart';

class ResetPasswordController extends GetxController {
  AuthRepository authRepository = AuthRepository();

  AuthenticationManager authManager = Get.find();
  final formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool loading = false.obs;
  dynamic args;
  RxString mobileNumberArgument = "".obs;
  bool passwordVisible = false;
  bool confirmpassword = false;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    mobileNumberArgument.value = args ?? "-----";
    update();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void setLoading(bool value) {
    loading.value = value;
    update();
  }

  Future<void> resetPasswordFunction(String mobileNumber) async {
    setLoading(true);
    authRepository.resetPassword({
      "username": "+$mobileNumber",
      "password": passwordController.text.toString()
    }).then((response) {
      if (response != null) {
        loading.value = false;
        if (response.statusCode == 200) {
          Get.offAllNamed(ROUTE_LOGIN_PAGE);
          getSnackBar(Tkey.resetPasswordSuccessfully.tr, SNACK.SUCCESS);
        } else {
          loading.value = false;
          getSnackBar(Tkey.tryAgain.tr, SNACK.FAILURE);
          log("Error: ${response.data}");
        }
        setLoading(false);
      }
    });
  }

  _togglePasswordView(type) {
    if (type == 0) {
      passwordVisible = !passwordVisible;
      update();
    }

    if (type == 1) {
      confirmpassword = !confirmpassword;
      update();
    }
  }
}
