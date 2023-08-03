import 'package:community_app/constants/responsive.dart';
import 'package:community_app/constants/style.dart';
import 'package:flutter/material.dart';

import '../constants/textstyle.dart';

class Customappbarwidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String? title;
  final double? elevation;
  final double? leadingWidth;
  final Widget? leading;
  final List<Widget>? actions;
  final void Function()? leadingonTap;
  final TextStyle? style;
  final double? fontSize;
  final Widget? leadingchild;
  const Customappbarwidget({
    super.key,
    this.title,
    this.elevation,
    this.leadingWidth,
    this.style,
    this.actions,
    this.leading,
    this.leadingonTap,
    this.leadingchild,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      title: Padding(
        padding: EdgeInsets.only(top: hp(2), left: wp(2)),
        child: Text(
          title ?? "",
          style: textMediumStyle.copyWith(
              fontFamily: fontMedium,
              fontSize: fontSize,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      leadingWidth: leadingWidth,
      leading: GestureDetector(
        onTap: leadingonTap,
        child: leadingchild,
      ),
      actions: actions,
    );
  }
}
