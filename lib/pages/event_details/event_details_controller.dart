import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/repositories/events_repository.dart';
import '../latest_events/model/events_model.dart';

class EventDetailsController extends GetxController {
  EventsRepository? eventsRepository;
  EventDetailsController({this.eventsRepository});
  RxList<Events> latestEventsList = <Events>[].obs;
  RxList<Events> upcomingEventsList = <Events>[].obs;
  Events? events;

  @override
  void onInit() {
    events = Get.arguments;
    getEventsFunction();
    super.onInit();
  }

  Future<void> getEventsFunction() async {
    eventsRepository?.getEvents().then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = response.data;
          final eventsData =
              jsonData['results']['latest_events'] as List<dynamic>;
          latestEventsList.value =
              eventsData.map((data) => Events.fromJson(data)).toList();
          final upcomingeventsData =
              jsonData['results']['upcoming_events'] as List<dynamic>;
          upcomingEventsList.value =
              upcomingeventsData.map((data) => Events.fromJson(data)).toList();
          update();
        } else {}
      }
    });
  }

  Future<void> likeEvent(int id, bool isLiked) async {
    eventsRepository
        ?.eventLikeAndBookmark(id, {"is_liked": isLiked}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          update();
          getEventsFunction();
        } else {}
      }
    });
  }

  Future<void> bookmarkEvent(int id, bool isBookmarked) async {
    eventsRepository?.eventLikeAndBookmark(
        id, {"is_bookmarked": isBookmarked}).then((response) {
      if (response != null) {
        if (response.statusCode == 200) {
          update();
          getEventsFunction();
        } else {}
      }
    });
  }

  void openGoogleMaps(String location) async {
    final encodedLocation = Uri.encodeComponent(location);
    String googleUrl = "geo:0,0?q=$encodedLocation";
    await launchUrl(Uri.parse(googleUrl));
  }
}
