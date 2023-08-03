import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/validation.dart';
import 'package:community_app/pages/auth/login/login_controller.dart';
import 'package:community_app/widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/responsive.dart';
import '../../../translation/key.dart';
import '../../../constants/textstyle.dart';
import '../../../routes/app_routes.dart';
import '../../../widget/custom_buttom.dart';
import '../../../widget/international_phone_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: hp(4)),
                SizedBox(
                  height: hp(45),
                  child: Stack(
                    children: [
                      Image.asset('assets/icons/2x/top_background_light.png'),
                      Positioned(
                          top: 45,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(ROUTE_REGITSER_PAGE);
                              controller.mobileNumberController.clear();
                              controller.passwordController.clear();
                              controller.update();
                            },
                            child: Text(Tkey.register.tr,
                                style: titleTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          )),
                      Positioned(
                        top: 150,
                        right: 50,
                        left: 50,
                        child: Lottie.asset(
                          'assets/lottie/login.json',
                          height: hp(25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: hp(1)),
                Text(Tkey.login.tr,
                    style: titleTextStyle.copyWith(
                        fontSize: 30,
                        color: Theme.of(context).primaryColorDark)),
                SizedBox(height: hp(1)),
                Text(Tkey.signInWithCredentials.tr,
                    style: textSmallStyle.copyWith(
                        color: Theme.of(context).primaryColorLight)),
                SizedBox(height: hp(3)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Internationalphonefield(
                            onCountryChanged: (value) {
                              controller.setCountryCode(value.dialCode);
                            },
                            flagsButtonMargin:
                                const EdgeInsets.symmetric(horizontal: 10),
                            controller: controller.mobileNumberController,
                            hintText: Tkey.enterMobileNumber.tr,
                            hintStyle: textMediumStyle.copyWith(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2)),
                            isDiaplayError: controller.numberfield.value,
                            onChanged: (p0) {
                              controller.mobileNumberController.text == ""
                                  ? controller.numberfield.value = true
                                  : controller.numberfield.value = false;
                            },
                          ),
                        ),
                        Obx(
                          () => controller.numberfield.value
                              ? Padding(
                                  padding: EdgeInsets.only(left: wp(4)),
                                  child: Text(
                                    Tkey.mobilenumberisrequired.tr,
                                    style: smallRegularTextStyle.copyWith(
                                        fontSize: 11,
                                        color: Colors.red.shade800),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(height: hp(2)),
                        CustomTextFormField(
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.passwordVisible =
                                    !controller.passwordVisible;
                                controller.update();
                              },
                              child: Icon(
                                controller.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            validationfunction: passwordValidator,
                            textEditingController:
                                controller.passwordController,
                            obscureText: !controller.passwordVisible,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: SvgPicture.asset(
                                  "assets/icons/ic_shield.svg"),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                minHeight: 26, minWidth: 26),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15),
                            textCapitalization: TextCapitalization.none,
                            textInputType: TextInputType.text,
                            hintText: Tkey.enterPassword.tr,
                            hintStyle: textMediumStyle.copyWith(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2))),
                        SizedBox(height: hp(2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.mobileNumberController.clear();
                                controller.passwordController.clear();
                                controller.update();
                                Get.toNamed(ROUTE_FORGET_PASSWORD_PAGE);
                              },
                              child: Text(Tkey.forgotPassword.tr,
                                  style: titleTextStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14)),
                            )
                          ],
                        ),
                        SizedBox(height: hp(3)),
                        InkWell(
                          onTap: () {
                            if (controller.formkey.currentState!.validate()) {
                              controller.numberfield.value = false;
                              controller.update();
                              if (controller
                                  .mobileNumberController.text.isNotEmpty) {
                                controller.loginUser(
                                    "${controller.countryCode}${controller.mobileNumberController.text}",
                                    controller.passwordController.text
                                        .toString());
                              }
                            } else {
                              controller.numberfield.value = true;
                              return;
                            }
                          },
                          child: Custombuttom(
                              child: controller.loading.value
                                  ? CircularProgressIndicator(
                                      color: COLOR_WHITE)
                                  : Text(
                                      Tkey.login.tr,
                                      style: textMediumStyle.copyWith(
                                          fontFamily: fontMedium,
                                          color: Colors.white),
                                    )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
