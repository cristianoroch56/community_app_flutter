import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:get/get.dart';

import 'my_members_controller.dart';

class MymembersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MymembersController>(
      () => MymembersController(
          accountSettingRepository:
              AccountSettingRepository(apiService: ApiService())),
    );
  }
}
