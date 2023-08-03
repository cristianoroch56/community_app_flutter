import 'package:get/get.dart';

import '../member_page/model/member_model.dart';
import '../my_members/model/my_members_model.dart';

class MembersProfileController extends GetxController {
  Data? member;
  MemberData? allmembers;

  @override
  void onInit() {
    if (Get.arguments is Data) {
      member = Get.arguments as Data?;
    } else {
      allmembers = Get.arguments as MemberData?;
    }
    super.onInit();
  }
}
