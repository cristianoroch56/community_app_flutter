import 'package:community_app/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../translation/key.dart';
import '../../data/repositories/account_setting_Repository.dart';
import '../my_members/my_members_controller.dart';

class AddMembersController extends GetxController {
  final AccountSettingRepository? accountSettingRepository;
  AddMembersController({this.accountSettingRepository});
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController mobilenoController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RxBool numberfield = false.obs;
  String? marital;
  RxBool showError = false.obs;
  bool loading = false;

  Future<void> addMember() async {
    if (formkey.currentState!.validate() &&
        (marital != null) &&
        mobilenoController.text.isNotEmpty) {
      numberfield.value = false;
      if (marital != null) {
        showError.value = false;
        loading = true;
        update();
        accountSettingRepository?.addNewMember(jsonData: {
          "first_name": firstnameController.text.toString(),
          "last_name": lastnameController.text.toString(),
          "mobile_number": mobilenoController.text.toString(),
          "relation_with_main_member": relationController.text.toString(),
          "birthdate": birthdateController.text.toString(),
          "education": educationController.text.toString(),
          "marital_status": marital.toString() == "Unmarried" ? "0" : "1",
          "currently_living_at": locationController.text.toString(),
        }).then((response) async {
          if (response != null) {
            loading = false;
            if (response.statusCode == 201) {
              if (Get.isRegistered<MymembersController>()) {
                MymembersController controller =
                    Get.find<MymembersController>();
                controller.getmembers();
              }
              Get.back();
              getSnackBar(Tkey.addmemberdatamessage.tr, SNACK.SUCCESS);
            } else {
              loading = false;
              getSnackBar(Tkey.mobilenumberalreadyexists.tr, SNACK.FAILURE);
            }
          }
        });
      }
    } else if (marital == null && mobilenoController.text.isEmpty) {
      numberfield.value = true;
      showError.value = true;
      loading = false;
    }
  }
}
