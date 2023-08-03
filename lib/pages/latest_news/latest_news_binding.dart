import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/latest_news/latest_news_controller.dart';
import 'package:get/get.dart';

class LatestNewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LatestNewsController>(
      () => LatestNewsController(
        newsRepository: NewsRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
