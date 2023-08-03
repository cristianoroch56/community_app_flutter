import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/add_members/add_members_controller.dart';
import 'package:get/get.dart';

class AddMembersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMembersController>(
      () => AddMembersController(
          accountSettingRepository:
              AccountSettingRepository(apiService: ApiService())),
    );
  }
}
