import 'package:community_app/pages/onboarding_page/onboarding_controller.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/widget/custom_next_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/responsive.dart';
import '../../constants/textstyle.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: hp(4)),
              Expanded(
                child: Stack(
                  children: [
                    Image.asset('assets/icons/2x/top_background_dark.png'),
                    Positioned(
                      top: hp(17),
                      left: wp(10),
                      right: wp(10),
                      child: SizedBox(
                        height: hp(33),
                        width: wp(50),
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller.pageController,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: hp(4)),
                                Image.asset(
                                  'assets/icons/3x/onboarding_image_1.png',
                                  scale: dp(context, 3.3),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/icons/3x/onboarding_image_2.png',
                              scale: dp(context, 2.8),
                            ),
                            Image.asset(
                              'assets/icons/3x/onboarding_image_3.png',
                              scale: dp(context, 2.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: hp(2)),
              Text(Tkey.welcomeTo.tr,
                  style: titleTextStyle.copyWith(
                      fontSize: 22,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.8))),
              Text(Tkey.appName.tr,
                  style: titleTextStyle.copyWith(
                      fontSize: 22,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.8))),
              SizedBox(height: hp(4)),
              SmoothPageIndicator(
                controller: controller.pageController!,
                effect: const SlideEffect(
                    activeDotColor: Color(0xFFD0658E),
                    dotWidth: 10,
                    dotHeight: 10),
                count: 3,
              ),
              Stack(
                children: [
                  Image.asset('assets/icons/2x/bottom_background_dark.png'),
                  Positioned(
                    top: 14,
                    left: 154,
                    right: 154,
                    bottom: 160,
                    child: CustomNextButton(
                      radius: 16,
                      onTap: () {
                        controller.navigateToNextPage();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
