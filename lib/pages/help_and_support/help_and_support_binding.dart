import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/help_and_support/help_and_support_controller.dart';
import 'package:get/get.dart';

class HelpAndSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpAndSupportController>(
      () => HelpAndSupportController(
        accountSettingRepository: AccountSettingRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
