import 'dart:developer';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../translation/key.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../authentication_manager.dart';

class ForgetPasswordController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  AuthenticationManager authManager = Get.find();
  NoInternetController noInternetController = Get.find();
  final formkey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  RxString countryCode = "1".obs;
  RxBool loading = false.obs;

  @override
  void onClose() {
    mobileNumberController.dispose();
    super.onClose();
  }

  void setLoading(bool value) {
    loading.value = value;
    update();
  }

  void setCountryCode(String newCountryCode) {
    countryCode.value = newCountryCode;
    update();
  }

  Future<void> forgetPasswordOtpFunction() async {
    await noInternetController.checkInternetConnectivity();
    if (noInternetController.hasInternetConnectivity.value) {
      setLoading(true);
      authRepository.forgetPasswordOtp({
        "username": "+$countryCode${mobileNumberController.text.toString()}"
      }).then((response) {
        if (response != null) {
          if (response.statusCode == 200) {
            Get.toNamed(ROUTE_OTP_PAGE, arguments: {
              'MobileNumber':
                  "$countryCode${mobileNumberController.text.toString()}",
              'isRegistrationFlow': false
            });

            getSnackBar(Tkey.verifyYourNumber.tr, SNACK.SUCCESS);
          } else {
            getSnackBar(Tkey.userIsNotRegistered.tr, SNACK.FAILURE);
            log("Error: ${response.data}");
          }
          setLoading(false);
        }
      });
      log("mobilenum in forget: $countryCode${mobileNumberController.text.toString()}");
    } else {
      getSnackBar(Tkey.noInternetConnectionFound.tr, SNACK.FAILURE);
    }
  }
}
