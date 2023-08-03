import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyprofileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyprofileController>(
      () => MyprofileController(
          accountSettingRepository:
              AccountSettingRepository(apiService: ApiService())),
    );
  }
}
