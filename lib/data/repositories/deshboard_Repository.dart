import '../services/api_service.dart';

class DeshboardRepository {
  final ApiService? apiService;
  DeshboardRepository({this.apiService});

  getnotification({Map<String, dynamic>? param}) {
    return apiService?.get("api/notification/", param: param);
  }

  deletenotification({int? id}) {
    return apiService?.delete(url: "api/notification/$id/");
  }

  getmember({Map<String, dynamic>? param}) {
    return apiService?.get("api/member/get_member/", param: param);
  }

  searchmember(String member) async {
    return apiService?.get("api/member/get_member/?name=$member");
  }
}
