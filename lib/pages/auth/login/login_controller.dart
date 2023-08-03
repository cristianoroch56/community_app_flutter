import 'dart:developer';
import 'dart:io';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/data/repositories/auth_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/pages/auth/cache_manager.dart';
import 'package:community_app/pages/auth/login/model/login_model.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController with CacheManager {
  AuthRepository authRepository = AuthRepository();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  NoInternetController noInternetController = Get.put(NoInternetController());
  AuthenticationManager authManager = Get.find();
  final formkey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString countryCode = "1".obs;
  RxBool loading = false.obs;
  RxBool numberfield = false.obs;
  bool passwordVisible = false;
  String? deviceToken;

  @override
  void onInit() {
    _firebaseMessaging.getToken().then((value) => deviceToken = value);
    super.onInit();
  }

  void setLoading(bool value) {
    loading.value = value;
    update();
  }

  void setCountryCode(String newCountryCode) {
    countryCode.value = newCountryCode;
    update();
  }

  LoginData? loginData;
  Future<void> loginUser(String mobileNumber, String password) async {
    await noInternetController.checkInternetConnectivity();
    if (noInternetController.hasInternetConnectivity.value) {
      setLoading(true);
      authRepository.login({
        "username": "+$mobileNumber",
        "password": password,
        "fcm_token": deviceToken,
        'device_type': Platform.isAndroid ? "android" : 'ios'
      }).then((response) {
        if (response != null) {
          if (response.statusCode == 200) {
            LoginModel loginModel = LoginModel.fromJson(response.data);
            loginData = loginModel.data;
            authManager.login(loginData?.token);
            authManager.saveToken(loginData?.token);
            authManager.saveUserId(loginData?.userDetails?.id.toString());
            authManager.saveName(loginData?.userDetails?.firstName.toString());
            // authManager.saveUser(ProfileData(
            //   user: loginData?.userDetails?.id,
            //   firstName: loginData?.userDetails?.firstName,
            //   lastName: loginData?.userDetails?.lastName,
            //   mobileNumber: loginData?.userDetails?.username,
            // )
            // );
            ApiService().setBaseToken(loginData?.token);
            Get.offAllNamed(ROUTE_DASHBOARD_PAGE);
            getSnackBar(Tkey.loggedInSuccessfully.tr, SNACK.SUCCESS);
          } else if (response.statusCode == 401 &&
              response.data['message']['error'].toString() ==
                  "[Verify OTP to active account]") {
            sendVerificationOtp(mobileNumber);
            Get.toNamed(ROUTE_OTP_PAGE, arguments: {
              'MobileNumber': mobileNumber,
              'isRegistrationFlow': true
            });
            getSnackBar(Tkey.activateYourAccout.tr, SNACK.SUCCESS);
          } else {
            getSnackBar(Tkey.invalidCredentials.tr, SNACK.FAILURE);
            log("Error: ${response.data}");
          }
          setLoading(false);
        }
      });
    } else {
      getSnackBar(Tkey.noInternetConnectionFound.tr, SNACK.FAILURE);
    }
  }

  Future<void> sendVerificationOtp(String mobileNumber) async {
    authRepository.resendOtp({"username": "+$mobileNumber"}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
        } else {
          log("Error: ${response.data}");
        }
      }
    });
  }
}
