import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/responsive.dart';
import '../constants/style.dart';
import '../translation/key.dart';
import '../constants/textstyle.dart';

class CustomReportButton extends StatelessWidget {
  final bool isReported;
  const CustomReportButton({
    super.key,
    required this.isReported,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/ic_report.svg",
          height: hp(2),
          colorFilter: ColorFilter.mode(
              isReported ? Colors.green : COLOR_PRIMARY, BlendMode.srcIn),
        ),
        SizedBox(width: wp(1)),
        Text(isReported ? Tkey.reported.tr : Tkey.report.tr,
            style: textMediumSmallStyle.copyWith(
                fontFamily: fontMedium,
                color: isReported ? Colors.green : COLOR_PRIMARY))
      ],
    );
  }
}
