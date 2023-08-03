import 'package:community_app/data/repositories/events_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/latest_events/latest_events_controller.dart';
import 'package:get/get.dart';

class LatestEventsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LatestEventsController>(
      () => LatestEventsController(
        eventsRepository: EventsRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
