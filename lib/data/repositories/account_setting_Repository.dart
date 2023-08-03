import 'package:community_app/data/services/api_service.dart';
import 'package:dio/dio.dart';

class AccountSettingRepository {
  final ApiService? apiService;
  AccountSettingRepository({this.apiService});

  patchnotification() {
    return apiService?.patch("api/user_profile/");
  }

  addNewMember({required Map<String, dynamic> jsonData}) async {
    return apiService?.post("api/member/create_member/", jsonData: jsonData);
  }

  getNewMember({Map<String, dynamic>? param}) {
    return apiService?.get("api/member/get_member/?flag=family_member",
        param: param);
  }

  searchmymember(String mymember) async {
    return apiService?.get("api/member/get_member/?name=$mymember");
  }

  getprofile({dynamic param}) {
    return apiService?.get("api/user_profile/", param: param);
  }

  putprofile({
    required FormData jsonData,
  }) {
    return apiService?.sendPutFile("api/user_profile/", jsonData: jsonData);
  }

  getprivacypolicy() {
    return apiService?.get("api/pages/?slug=privacy_policy");
  }

  Future<Response?> postHelpAndSupport(
      {required Map<String, dynamic> jsonData}) async {
    return apiService!.post("api/help_and_support/", jsonData: jsonData);
  }
}
