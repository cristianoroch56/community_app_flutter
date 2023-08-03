import 'package:community_app/data/services/api_service.dart';
import 'package:get/get.dart';
import '../../data/repositories/deshboard_Repository.dart';
import 'notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
          deshboardRepository: DeshboardRepository(apiService: ApiService())),
    );
  }
}
