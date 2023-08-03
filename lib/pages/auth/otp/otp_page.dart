import 'package:community_app/constants/style.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/pages/auth/otp/otp_controller.dart';
import 'package:community_app/widget/custom_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../constants/responsive.dart';

class OtpPage extends StatelessWidget {
  final String mobileNumber;
  final bool isRegistrationFlow;
  const OtpPage(
      {super.key,
      required this.mobileNumber,
      required this.isRegistrationFlow});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      init: OtpController(),
      initState: (_) {},
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: hp(61.5),
                    child: Stack(
                      children: [
                        Image.asset('assets/icons/2x/top_background_light.png'),
                        Positioned(
                          top: 185,
                          right: 50,
                          left: 50,
                          child: Lottie.asset(
                            'assets/lottie/otp.json',
                            height: hp(35),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: hp(3)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(Tkey.enterOTPSendTo.tr,
                                style: titleTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorDark)),
                            Text("+${controller.mobileNumberArgument.value}",
                                style: titleTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorDark)),
                          ],
                        ),
                        SizedBox(height: hp(3)),
                        Center(
                          child: Pinput(
                            controller: controller.pinputController,
                            textInputAction: TextInputAction.done,
                            defaultPinTheme: PinTheme(
                              height: 52,
                              width: 52,
                              textStyle: textMediumStyle.copyWith(
                                  color: Theme.of(context).primaryColorDark),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.24),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              height: 52,
                              width: 52,
                              textStyle: textMediumStyle.copyWith(
                                  color: Theme.of(context).primaryColorDark),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.5),
                                    width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: hp(2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (controller.timer?.isActive ?? false)
                                ? SvgPicture.asset(
                                    'assets/icons/ic_message_light.svg',
                                    height: 10)
                                : SvgPicture.asset(
                                    'assets/icons/ic_message.svg',
                                    height: 10),
                            SizedBox(width: wp(1)),
                            InkWell(
                                onTap: () {
                                  controller.resentOtpTimer(
                                      controller.mobileNumberArgument.value);
                                },
                                child: Text(Tkey.resendOtp.tr,
                                    style: smallRegularTextStyle.copyWith(
                                        color: (controller.timer?.isActive ??
                                                false)
                                            ? Theme.of(context)
                                                .primaryColorLight
                                                .withOpacity(0.24)
                                            : Theme.of(context).primaryColor))),
                            SizedBox(width: wp(2)),
                            Text("|",
                                style: smallRegularTextStyle.copyWith(
                                    fontFamily: fontMedium,
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.24))),
                            SizedBox(width: wp(2)),
                            Text(Tkey.requestOtpAgainIn.tr,
                                style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.24))),
                            Obx(() => Text(
                                "00:${controller.start.value.toString().padLeft(2, '0')}",
                                style: smallRegularTextStyle.copyWith(
                                    fontFamily: fontMedium,
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.8)))),
                          ],
                        ),
                        SizedBox(height: hp(6)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomNextButton(
                                radius: 24,
                                onTap: () {
                                  controller.navigateToNextScreen(
                                      controller.mobileNumberArgument.value,
                                      controller.pinputController.text
                                          .toString());
                                })
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
