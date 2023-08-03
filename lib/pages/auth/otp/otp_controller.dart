import 'dart:async';
import 'package:community_app/pages/auth/forget_password/forget_password_controller.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/functions.dart';
import '../../../translation/key.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/api_service.dart';
import '../authentication_manager.dart';

class OtpController extends GetxController {
  AuthRepository authRepository = AuthRepository();

  dynamic args;
  RxBool isRegistrationFlow = true.obs;
  RxInt start = 60.obs;
  Timer? timer;

  AuthenticationManager authManager = Get.find();
  TextEditingController pinputController = TextEditingController();
  RxString mobileNumberArgument = "".obs;

  @override
  void onInit() {
    resetTimer();
    super.onInit();
    mobileNumberArgument.value = Get.arguments['MobileNumber'] ?? 'null';
    isRegistrationFlow.value = Get.arguments['isRegistrationFlow'] ?? true;
    update();
  }

  @override
  void onClose() {
    pinputController.dispose();
    timer?.cancel();
    super.onClose();
  }

  void resetTimer() {
    timer?.cancel();
    start.value = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (start.value == 0) {
        update();
        start.value = 60;
        timer.cancel();
      } else {
        start.value--;
        update();
      }
    });
  }

  void setRegistrationFlow(bool isRegistrationFlow) {
    this.isRegistrationFlow.value = isRegistrationFlow;
    update();
  }

  void navigateToNextScreen(String mobileNumber, String otp) {
    if (pinputController.text.length < 4) {
      getSnackBar(Tkey.otpisRequired.tr, SNACK.FAILURE);
    } else {
      if (isRegistrationFlow.value) {
        verifyOtpFunction(mobileNumber, otp);
      } else {
        verifyForgetPasswordOtpFunction(mobileNumber, otp);
      }
    }
  }

  Future<void> verifyOtpFunction(String mobileNumber, String otp) async {
    authRepository
        .verifyOtp({"username": "+$mobileNumber", "otp": otp}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          Get.offAllNamed(ROUTE_LOGIN_PAGE);
          getSnackBar(Tkey.accountActivated.tr, SNACK.SUCCESS);
        } else {
          getSnackBar(Tkey.invalidOtp.tr, SNACK.FAILURE);
        }
      }
    });
  }

  Future<void> verifyForgetPasswordOtpFunction(
      String mobileNumber, String otp) async {
    authRepository.verifyForgetPasswordOtp(
        {"username": "+$mobileNumber", "otp": otp}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          String token = response.data['data']['token'];
          ApiService().setBaseToken(token);
          Get.toNamed(ROUTE_RESETPASSWORD_PAGE, arguments: mobileNumber);
          getSnackBar(Tkey.accountVerified.tr, SNACK.SUCCESS);
        } else {
          getSnackBar(Tkey.invalidOtp.tr, SNACK.FAILURE);
        }
      }
    });
  }

  Future<void> resendOtpFunction(String mobileNumber) async {
    authRepository.resendOtp({"username": "+$mobileNumber"}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          getSnackBar(Tkey.resentOtpSuccessfully.tr, SNACK.SUCCESS);
        } else {
          getSnackBar(Tkey.otpRequestFailed.tr, SNACK.FAILURE);
        }
      }
    });
  }

  void resentOtpTimer(String mobileNumber) {
    if (start.value == 60) {
      if (isRegistrationFlow.value) {
        resendOtpFunction(mobileNumber);
      } else {
        ForgetPasswordController forgetPasswordController = Get.find();
        forgetPasswordController.forgetPasswordOtpFunction();
      }
      resetTimer();
    }
  }
}
