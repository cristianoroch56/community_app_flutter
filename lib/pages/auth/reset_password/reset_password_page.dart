import 'package:community_app/constants/style.dart';
import 'package:community_app/pages/auth/reset_password/reset_password_controller.dart';
import 'package:community_app/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/responsive.dart';
import '../../../translation/key.dart';
import '../../../constants/textstyle.dart';
import '../../../constants/validation.dart';
import '../../../widget/custom_textformfield.dart';

class ResetPasswordPage extends StatelessWidget {
  final String mobileNumber;
  const ResetPasswordPage({super.key, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                Text(Tkey.resetPassword.tr,
                    style: titleTextStyle.copyWith(
                        fontSize: 24,
                        color: Theme.of(context).primaryColorDark)),
                SizedBox(height: hp(1)),
                Text(Tkey.enterNewPassword.tr,
                    style: textSmallStyle.copyWith(
                        color: Theme.of(context).primaryColorLight)),
                SizedBox(height: hp(4)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          validationfunction: passwordValidator,
                          obscureText: !controller.passwordVisible,
                          maxLines: 1,
                          textEditingController: controller.passwordController,
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
                          hintText: Tkey.enterNewPassword.tr,
                          hintStyle: textMediumStyle.copyWith(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2)),
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
                        ),
                        SizedBox(height: hp(3)),
                        CustomTextFormField(
                          validationfunction: (val) {
                            if (val!.isEmpty) return Tkey.passwordIsRequired.tr;
                            if (val != controller.passwordController.text) {
                              return Tkey.confirmPasswordMustBeSame.tr;
                            }
                            return null;
                          },
                          textEditingController:
                              controller.confirmPasswordController,
                          obscureText: !controller.confirmpassword,
                          maxLines: 1,
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
                          hintText: Tkey.confirmPassword.tr,
                          hintStyle: textMediumStyle.copyWith(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2)),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.confirmpassword =
                                  !controller.confirmpassword;
                              controller.update();
                            },
                            child: Icon(
                              controller.confirmpassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                        SizedBox(height: hp(3)),
                        AbsorbPointer(
                          absorbing: controller.loading.value,
                          child: InkWell(
                              onTap: () {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  controller.update();
                                  controller.resetPasswordFunction(
                                      controller.mobileNumberArgument.value);
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
                                          Tkey.resetPassword.tr,
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
