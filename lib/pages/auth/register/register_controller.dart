import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../authentication_manager.dart';

class RegisterController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  AuthenticationManager authManager = Get.find();
  NoInternetController noInternetController = Get.find();
  RxBool numberfield = false.obs;
  final formkey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString countryCode = "1".obs;
  RxBool loading = false.obs;
  bool passwordVisible = false;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
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

  Future<void> registerUser(String firstName, String lastName,
      String mobileNumber, String password) async {
    await noInternetController.checkInternetConnectivity();
    if (noInternetController.hasInternetConnectivity.value) {
      setLoading(true);
      authRepository.register({
        "first_name": firstName,
        "last_name": lastName,
        "username": "+$mobileNumber",
        "password": password
      }).then((response) {
        if (response != null) {
          if (response.statusCode == 201) {
            Get.toNamed(ROUTE_OTP_PAGE, arguments: {
              'MobileNumber': mobileNumber,
              'isRegistrationFlow': true
            });
            getSnackBar(Tkey.activateYourAccout.tr, SNACK.SUCCESS);
          } else {
            getSnackBar(Tkey.userIsAlreadyRegistered.tr, SNACK.FAILURE);
          }
          setLoading(false);
        }
      });
    } else {
      getSnackBar(Tkey.noInternetConnectionFound.tr, SNACK.FAILURE);
    }
  }
}
