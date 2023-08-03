import 'package:community_app/constants/responsive.dart';
import 'package:community_app/constants/style.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/pages/account_setting_Page/account_setting_controller.dart';
import 'package:community_app/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/textstyle.dart';
import '../../routes/app_routes.dart';
import '../../widget/custom_alert_dialogue.dart';

class AccountsettingPage extends StatelessWidget {
  const AccountsettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountsettingController>(
        init: AccountsettingController(),
        initState: (_) {},
        builder: (controller) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Customappbarwidget(
              leadingWidth: wp(0),
              title: Tkey.accountSettings.tr,
              fontSize: 22,
              elevation: 0.3,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(1)),
              children: [
                RowWidget(
                  onTap: () {
                    Get.toNamed(ROUTE_MYPROFILE_PAGE);
                  },
                  text: Tkey.accountProfile.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: hp(1),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Tkey.accountPushNotification.tr,
                          style: textMediumStyle.copyWith(
                            fontFamily: fontMedium,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        FlutterSwitch(
                          activeColor: Theme.of(context).primaryColor,
                          width: wp(13),
                          height: hp(3.4),
                          valueFontSize: 0.0,
                          value: controller.isSwitched.value,
                          borderRadius: 30.0,
                          padding: 5.0,
                          showOnOff: true,
                          onToggle: (value) {
                            controller.toggleSwitch(value);
                          },
                        ),
                      ]),
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                RowWidget(
                  onTap: () {
                    Get.toNamed(ROUTE_MYMEMBERS_PAGE);
                  },
                  text: Tkey.accountMyMembers.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                RowWidget(
                  onTap: () {},
                  text: Tkey.accountPrivacyPolicy.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                RowWidget(
                  onTap: () {},
                  text: Tkey.accountTermsConditions.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                RowWidget(
                  onTap: () {
                    Get.toNamed(ROUTE_HELPANDSUPPORT_PAGE);
                  },
                  text: Tkey.accountHelpSupport.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                RowWidget(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => CustomAlertDialog(
                        title: Text(
                          Tkey.accountLogout.tr,
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          Tkey.areYouSureYouWantToLogout.tr,
                          textAlign: TextAlign.center,
                        ),
                        onPressedNo: () {
                          Get.back();
                        },
                        onPressedYes: () {
                          AuthenticationManager().logOut();
                        },
                      ),
                    );
                  },
                  text: Tkey.accountLogout.tr,
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                ),
                SizedBox(
                  height: hp(14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          launchUrl(
                              Uri.parse(
                                  "https://www.instagram.com/wappnetsystems/"),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset("assets/icons/1.5x/insta.png",
                            scale: 20)),
                    SizedBox(width: wp(4)),
                    InkWell(
                        onTap: () {
                          launchUrl(
                              Uri.parse(
                                  'https://wa.me/${916353604125}?text=Hi'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset("assets/icons/1.5x/whatsapp.png",
                            scale: 20)),
                    SizedBox(width: wp(4)),
                    InkWell(
                        onTap: () {
                          launchUrl(
                              Uri.parse(
                                  'https://www.facebook.com/wappnetsystems/'),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Image.asset("assets/icons/1.5x/facebook.png",
                            scale: 20)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class RowWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  const RowWidget({super.key, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(1.7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$text",
              style: textMediumStyle.copyWith(
                  fontFamily: fontMedium,
                  color: Theme.of(context).primaryColorDark),
            ),
          ],
        ),
      ),
    );
  }
}
