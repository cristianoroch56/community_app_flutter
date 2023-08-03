import 'package:community_app/data/repositories/deshboard_Repository.dart';
import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/message_page/message_controller.dart';
import 'package:get/get.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(
        deshboardRepository: DeshboardRepository(
          apiService: ApiService(),
        ),
        messageRepository: MessageRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
