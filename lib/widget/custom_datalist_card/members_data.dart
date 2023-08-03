import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/pages/member_page/member_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/responsive.dart';
import '../../pages/member_page/model/member_model.dart';
import '../../translation/key.dart';

class MembersData extends StatelessWidget {
  final MemberData? allmembers;
  const MembersData({super.key, this.allmembers});

  @override
  Widget build(BuildContext context) {
    String imageUrl = allmembers?.profilePic ?? "";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            blurRadius: 10.0,
          ),
          BoxShadow(
            color: COLOR_LIGHTGRAY,
            blurRadius: 10.0,
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: wp(3), vertical: hp(1.5)),
      margin: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(0.2)),
      child: InkWell(
        onTap: () {
          // Get.toNamed(ROUTE_MEMBERSPROFILE_PAGE, arguments: allmembers);
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: COLOR_PRIMARY,
              radius: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  imageUrl,
                  height: hp(6.9),
                  width: wp(14),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                        "${allmembers!.firstName?.substring(0, 1).toUpperCase()}${allmembers!.lastName?.substring(0, 1).toUpperCase()}",
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor));
                  },
                ),
              ),
            ),
            SizedBox(width: wp(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: wp(45),
                  child: Text(
                      "${allmembers!.firstName} ${allmembers!.lastName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context).primaryColorDark)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("${Tkey.iD.tr}: ${allmembers?.user}",
                      style: smallRegularTextStyle.copyWith(
                          color: Theme.of(context).primaryColorLight)),
                ),
              ],
            ),
            const Spacer(),
            GetBuilder<MemberController>(
              init: MemberController(),
              initState: (_) {},
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.only(right: wp(5)),
                  child: InkWell(
                    onTap: () {
                      print("allmembers");
                      controller.createThreadFunction(allmembers!.user!);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_chat.svg",
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColorDark, BlendMode.srcIn),
                      height: hp(2.5),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: wp(5)),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: COLOR_ARROW,
                size: hp(2.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
