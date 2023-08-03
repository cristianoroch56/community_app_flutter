import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/chat_page/chat_page_controller.dart';
import 'package:get/get.dart';

class ChatPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPageController>(
      () => ChatPageController(
        messageRepository: MessageRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
