// ignore_for_file: unrelated_type_equality_checks

import 'package:community_app/translation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/responsive.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';
import '../my_members/model/my_members_model.dart';
import 'members_profile_controller.dart';

class MembersProfilePage extends StatelessWidget {
  final Data? member;
  const MembersProfilePage({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembersProfileController>(
        init: MembersProfileController(),
        initState: (_) {},
        builder: (controller) {
          String imageUrl = controller.allmembers?.profilePic ?? "";
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Customappbarwidget(
              leadingonTap: () {
                Get.back();
              },
              leadingchild: Padding(
                padding: EdgeInsets.only(top: hp(2), left: wp(4)),
                child: SvgPicture.asset(
                  "assets/icons/ic_back.svg",
                  height: hp(2.4),
                  width: wp(2.4),
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColorDark, BlendMode.srcIn),
                ),
              ),
              elevation: 0.0,
            ),
            body: controller == ""
                ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: hp(3)),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: dp(context, 60),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(dp(context, 60)),
                              child: Image.network(
                                imageUrl,
                                height: hp(17),
                                width: wp(33.2),
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Text(
                                    controller.member == null
                                        ? "${controller.allmembers?.firstName?.substring(0, 1)}${controller.allmembers?.lastName?.substring(0, 1)}"
                                        : "${controller.member?.firstName?.substring(0, 1)}${controller.member?.lastName?.substring(0, 1)}",
                                    style: titleTextStyle.copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: hp(2)),
                        Text(
                          controller.member == null
                              ? "${controller.allmembers?.firstName} ${controller.allmembers?.lastName}"
                              : "${controller.member?.firstName} ${controller.member?.lastName}",
                          style: titleTextStyle.copyWith(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 22),
                        ),
                        SizedBox(height: hp(1)),
                        Text(
                          controller.member == null
                              ? " ${Tkey.userID.tr}: ${controller.allmembers?.user ?? 'N/A'}"
                              : "${Tkey.userID.tr}: ${controller.member?.user ?? 'N/A'}",
                          style: textMediumStyle.copyWith(
                              color: Theme.of(context).primaryColorDark),
                        ),
                        SizedBox(height: hp(3)),
                        Container(
                          height: hp(45.5),
                          width: wp(91),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    const Color(0xffFB796B),
                                    const Color(0xffD0658E),
                                  ])),
                          child: Container(
                            height: hp(45),
                            width: wp(90),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: wp(5), right: wp(5), top: hp(4)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.firstnametext.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller
                                                    .allmembers?.firstName ??
                                                'N/A'
                                            : controller.member?.firstName ??
                                                'N/A',
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.lastnametext.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller.allmembers?.lastName ??
                                                'N/A'
                                            : controller.member?.lastName ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.mobileNo.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller
                                                    .allmembers?.mobileNumber ??
                                                'N/A'
                                            : controller.member?.mobileNumber ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.relation.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller.allmembers
                                                    ?.relationWithMainMember ??
                                                'N/A'
                                            : controller.member
                                                    ?.relationWithMainMember ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.birthdate.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller
                                                    .allmembers?.birthdate ??
                                                'N/A'
                                            : controller.member?.birthdate ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.education.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller
                                                    .allmembers?.education ??
                                                'N/A'
                                            : controller.member?.education ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.maritalStatus.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      controller.member == null
                                          ? Text(
                                              controller.allmembers
                                                          ?.maritalStatus ==
                                                      null
                                                  ? 'N/A'
                                                  : 'N/A',
                                              style: textSmallStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  fontSize: dp(context, 14)),
                                            )
                                          : Text(
                                              controller.member
                                                          ?.maritalStatus ==
                                                      true
                                                  ? Tkey.married.tr
                                                  : Tkey.unmarried.tr,
                                              style: textMediumStyle.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: hp(2)),
                                  Row(
                                    children: [
                                      Text(
                                        Tkey.currentlyLiving.tr,
                                        style: textMediumStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: textSmallStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.member == null
                                            ? controller.allmembers
                                                    ?.currentlyLivingAt ??
                                                'N/A'
                                            : controller.member
                                                    ?.currentlyLivingAt ??
                                                'N/A',
                                        style: textSmallStyle.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: hp(2),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
