import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:community_app/data/services/api_service.dart';
import 'package:community_app/pages/account_setting_Page/account_setting_controller.dart';
import 'package:get/get.dart';

class AccountsettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountsettingController>(
      () => AccountsettingController(
        accountSettingRepository: AccountSettingRepository(
          apiService: ApiService(),
        ),
      ),
    );
  }
}
