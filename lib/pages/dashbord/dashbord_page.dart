import 'package:community_app/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/textstyle.dart';
import '../../translation/key.dart';
import 'dashboard_controller.dart';

class DashbordPage extends StatelessWidget {
  const DashbordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      initState: (_) {},
      builder: (logic) {
        return Scaffold(
          body: Obx(
            () => IndexedStack(
              index: logic.selectedIndex.value,
              children: logic.Screen,
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomAppBar(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: const CircularNotchedRectangle(),
              notchMargin: 5,
              child: SizedBox(
                height: hp(6.5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        logic.selectedIndex.value = 0;
                      },
                      child: logic.selectedIndex.value == 0
                          ? Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_home1.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.home.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ])
                          : Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_home.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.home.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorLight,
                                  ))
                            ]),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        logic.selectedIndex.value = 1;
                      },
                      child: logic.selectedIndex.value == 1
                          ? Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_profile1.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.members.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ])
                          : Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_profile.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.members.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorLight,
                                  ))
                            ]),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        logic.selectedIndex.value = 2;
                      },
                      child: logic.selectedIndex.value == 2
                          ? Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_sms1.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.messag.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ])
                          : Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_sms.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.messag.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorLight,
                                  ))
                            ]),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        logic.selectedIndex.value = 3;
                      },
                      child: logic.selectedIndex.value == 3
                          ? Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_user1.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.profile.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ])
                          : Column(children: [
                              SizedBox(height: hp(0.7)),
                              SvgPicture.asset(
                                'assets/icons/ic_user.svg',
                                height: hp(3),
                                width: wp(3),
                              ),
                              SizedBox(height: hp(0.2)),
                              Text(Tkey.profile.tr,
                                  style: smallRegularTextStyle.copyWith(
                                    color: Theme.of(context).primaryColorLight,
                                  ))
                            ]),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
