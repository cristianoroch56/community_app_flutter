import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/style.dart';
import '../constants/responsive.dart';

class CustomNextButton extends StatelessWidget {
  final double radius;
  final void Function()? onTap;
  const CustomNextButton(
      {super.key, required this.radius, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          height: hp(6.5),
          width: wp(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              colors: [secondaryColor1, secondaryColor2, COLOR_PRIMARY],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Center(
              child: SvgPicture.asset("assets/icons/ic_arrow_right.svg",
                  height: 24, width: 24)),
        ),
      ),
    );
  }
}
