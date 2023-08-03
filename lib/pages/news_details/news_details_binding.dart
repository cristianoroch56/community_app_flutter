import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/news_details/news_details_controller.dart';
import 'package:get/get.dart';

class NewsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsController>(
      () => NewsDetailsController(
        newsRepository: NewsRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
