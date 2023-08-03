import 'dart:developer';
import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:get/get.dart';

class AccountsettingController extends GetxController {
  AccountSettingRepository? accountSettingRepository;
  AccountsettingController({this.accountSettingRepository});
  final RxBool isSwitched = false.obs;
  void toggleSwitch(bool value) {
    isSwitched.value = value;
    patchNotification();
    update();
  }

  Future<void> patchNotification() async {
    var res = await accountSettingRepository?.patchnotification();
    if (res != null) {
      if (res.statusCode == 200) {
      } else {}
    } else {
      log(":null");
    }
  }
}
