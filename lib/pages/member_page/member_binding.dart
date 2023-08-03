import 'package:community_app/data/repositories/deshboard_Repository.dart';
import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/member_page/member_controller.dart';
import 'package:get/get.dart';

class MemberBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberController>(
      () => MemberController(
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
