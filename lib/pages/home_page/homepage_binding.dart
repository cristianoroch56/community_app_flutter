import 'package:community_app/data/repositories/events_repository.dart';
import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/home_page/homepage_controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(
      () => HomePageController(
        eventsRepository: EventsRepository(
          apiService: ApiService(),
        ),
        newsRepository: NewsRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
