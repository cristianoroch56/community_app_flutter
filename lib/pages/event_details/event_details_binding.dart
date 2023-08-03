import 'package:community_app/data/repositories/events_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/event_details/event_details_controller.dart';
import 'package:get/get.dart';

class EventDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventDetailsController>(
      () => EventDetailsController(
        eventsRepository: EventsRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
