import 'package:community_app/pages/auth/forget_password/forget_password_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(
      () => ForgetPasswordController(),
    );
  }
}
