import 'package:community_app/data/services/api_service.dart';

class MessageRepository {
  final ApiService? apiService;
  MessageRepository({this.apiService});

  createThread({Map<String, dynamic>? jsonData}) async {
    return apiService?.post("api/chat/threads/", jsonData: jsonData);
  }

  getThreads() async {
    return apiService?.get("api/chat/threads/");
  }

  getThreadByName(String name) async {
    return apiService?.get("api/chat/threads/?name=$name");
  }

  getMessages({Map<String, dynamic>? param}) async {
    return apiService?.get("api/chat/messages/", param: param);
  }
}
