import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/responsive.dart';
import '../../pages/my_members/model/my_members_model.dart';
import '../../translation/key.dart';

class MyMembersData extends StatelessWidget {
  final Data? member;
  const MyMembersData({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ROUTE_MEMBERSPROFILE_PAGE, arguments: member);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        margin: EdgeInsets.symmetric(vertical: hp(0), horizontal: wp(0.2)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: hp(1), bottom: hp(0.5), left: wp(2)),
                  child: CircleAvatar(
                    backgroundColor: COLOR_PRIMARY,
                    radius: 30,
                    child: Image.network(
                      "${member!.profilePic}",
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          "${member?.firstName?.substring(0, 1).toUpperCase()}${member?.lastName?.substring(0, 1).toUpperCase()}",
                          style: titleTextStyle.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: wp(5)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${member?.firstName} ${member?.lastName}",
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark)),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(member?.currentlyLivingAt ?? 'N/A',
                          style: textSmallStyle.copyWith(
                              color: COLOR_PRIMARYLIGHT)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text("${Tkey.iD.tr}: ${member?.user ?? 'N/A'}",
                          style: textSmallStyle.copyWith(
                              color: COLOR_PRIMARYLIGHT)),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: wp(5)),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).primaryColorDark,
                    size: hp(2.5),
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: COLOR_LIGHTGRAY)
          ],
        ),
      ),
    );
  }
}
