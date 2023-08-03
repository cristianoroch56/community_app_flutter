import 'package:community_app/constants/style.dart';
import 'package:community_app/pages/auth/forget_password/forget_password_controller.dart';
import 'package:community_app/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/responsive.dart';
import '../../../routes/app_routes.dart';
import '../../../translation/key.dart';
import '../../../constants/textstyle.dart';
import '../../../widget/international_phone_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      initState: (_) {},
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            Get.offAllNamed(ROUTE_LOGIN_PAGE);
            return true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: hp(4)),
                  Stack(
                    children: [
                      Image.asset('assets/icons/2x/top_background_light.png'),
                      Positioned(
                          top: 90,
                          bottom: 37,
                          left: 130,
                          right: 130,
                          child: Image.asset("assets/icons/1.5x/app_logo.png"))
                    ],
                  ),
                  SizedBox(height: hp(3)),
                  Text(Tkey.forgotPassword.tr,
                      style: titleTextStyle.copyWith(
                          fontSize: 30,
                          color: Theme.of(context).primaryColorDark)),
                  SizedBox(height: hp(1)),
                  Text(Tkey.enterMobileNumberToResetPassword.tr,
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.5))),
                  SizedBox(height: hp(4)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: controller.formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Internationalphonefield(
                                  onCountryChanged: (value) {
                                    controller.setCountryCode(value.dialCode);
                                  },
                                  textInputAction: TextInputAction.done,
                                  flagsButtonMargin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  controller: controller.mobileNumberController,
                                  hintText: Tkey.enterMobileNumber.tr,
                                  hintStyle: textMediumStyle.copyWith(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.2)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.24),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: hp(3)),
                          InkWell(
                              onTap: () {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  controller.update();
                                  controller.forgetPasswordOtpFunction();
                                } else {
                                  return;
                                }
                              },
                              child: Custombuttom(
                                  child: controller.loading.value
                                      ? CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor)
                                      : Text(
                                          Tkey.sendOtp.tr,
                                          style: textMediumStyle.copyWith(
                                              color: Colors.white,
                                              fontFamily: fontMedium),
                                        )))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
