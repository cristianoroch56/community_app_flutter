import 'dart:developer';
import 'package:community_app/translation/key.dart';
import 'package:community_app/constants/validation.dart';
import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/responsive.dart';
import 'package:community_app/pages/auth/register/register_controller.dart';
import 'package:community_app/widget/custom_buttom.dart';
import 'package:community_app/widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/textstyle.dart';
import '../../../routes/app_routes.dart';
import '../../../widget/international_phone_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: hp(4)),
                Stack(
                  children: [
                    Image.asset('assets/icons/2x/top_background_light.png'),
                    Positioned(
                        top: 60,
                        right: 20,
                        child: InkWell(
                            onTap: () {
                              Get.offAllNamed(ROUTE_LOGIN_PAGE);
                            },
                            child: Text(Tkey.login.tr,
                                style: titleTextStyle.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor)))),
                    Positioned(
                        top: 90,
                        bottom: 37,
                        left: 130,
                        right: 130,
                        child: Image.asset("assets/icons/1.5x/app_logo.png"))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Tkey.register.tr,
                            style: titleTextStyle.copyWith(
                                color: Theme.of(context).primaryColorDark)),
                        SizedBox(height: hp(3)),
                        CustomTextFormField(
                            validationfunction: nameValidator,
                            textEditingController:
                                controller.firstNameController,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.24),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            textCapitalization: TextCapitalization.words,
                            textInputType: TextInputType.text,
                            hintText: Tkey.firstName.tr,
                            hintStyle: textMediumStyle.copyWith(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2))),
                        SizedBox(height: hp(3)),
                        CustomTextFormField(
                            validationfunction: nameValidator,
                            textEditingController:
                                controller.lastNameController,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.24),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            textCapitalization: TextCapitalization.words,
                            textInputType: TextInputType.text,
                            hintText: Tkey.lastName.tr,
                            hintStyle: textMediumStyle.copyWith(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2))),
                        SizedBox(height: hp(3)),
                        Obx(
                          () => Internationalphonefield(
                            controller: controller.mobileNumberController,
                            onCountryChanged: (value) {
                              controller.setCountryCode(value.dialCode);
                            },
                            flagsButtonMargin:
                                const EdgeInsets.symmetric(horizontal: 10),
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
                        SizedBox(height: hp(3)),
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
                            obscureText: !controller.passwordVisible,
                            maxLines: 1,
                            textEditingController:
                                controller.passwordController,
                            textInputAction: TextInputAction.done,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.24),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            textCapitalization: TextCapitalization.none,
                            textInputType: TextInputType.text,
                            hintText: Tkey.enterPassword.tr,
                            hintStyle: textMediumStyle.copyWith(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2))),
                        SizedBox(height: hp(3)),
                        AbsorbPointer(
                          absorbing: controller.loading.value,
                          child: InkWell(
                              onTap: () {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  controller.registerUser(
                                      controller.firstNameController.text
                                          .toString(),
                                      controller.lastNameController.text
                                          .toString(),
                                      "${controller.countryCode}${controller.mobileNumberController.text}",
                                      controller.passwordController.text
                                          .toString());
                                  log("${controller.countryCode}${controller.mobileNumberController.text}");
                                } else {
                                  controller.numberfield.value = true;
                                  return;
                                }
                              },
                              child: Custombuttom(
                                  child: controller.loading.value
                                      ? CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor)
                                      : Text(
                                          Tkey.register.tr,
                                          style: textMediumStyle.copyWith(
                                              fontFamily: fontMedium,
                                              color: Colors.white),
                                        ))),
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
