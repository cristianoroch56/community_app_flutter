import 'package:community_app/data/services/api_service.dart';

class EventsRepository {
  final ApiService? apiService;
  EventsRepository({this.apiService});

  getEvents({Map<String, dynamic>? param}) async {
    return apiService?.get("api/event/", param: param);
  }

  searchEvents(String event) async {
    return apiService?.get("api/event/search_events/?event=$event");
  }

  eventLikeAndBookmark(int id, Map<String, dynamic>? jsonData) async {
    return apiService?.patch("api/event/$id/", data: jsonData);
  }
}
