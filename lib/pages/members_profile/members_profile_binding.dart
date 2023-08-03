import 'package:get/get.dart';
import 'members_profile_controller.dart';

class MembersProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MembersProfileController>(
      () => MembersProfileController(),
    );
  }
}
