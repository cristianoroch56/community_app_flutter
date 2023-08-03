import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/my_profile/model/profile_model.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:get/get.dart';

import 'cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  final userData = ProfileData().obs;
  String? language;

  void logOut() {
    isLogged.value = false;
    removeToken();
    ApiService().removeBaseToken();
    Get.offAllNamed(ROUTE_LOGIN_PAGE);
  }

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  setLanguage(String? localLanguage) async {
    language = localLanguage;
    await saveLanguage(localLanguage ?? "en_US");
  }

  saveName(String? userName) async {
    await saveUserName(userName);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      // Map<String, dynamic>? userMap = getUserData();
      // ProfileData user = ProfileData.fromJson(userMap!);
      // userData.value = user;
      isLogged.value = true;
    }
  }
}

class UserData {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String userId;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.userId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      userId: json['user_id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'user_id': userId,
    };
  }
}
