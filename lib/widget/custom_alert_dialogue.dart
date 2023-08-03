import 'package:community_app/constants/style.dart';
import 'package:community_app/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translation/key.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Function()? onPressedNo;
  final Function()? onPressedYes;
  const CustomAlertDialog(
      {super.key,
      this.title,
      this.content,
      this.onPressedNo,
      this.onPressedYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      title: title,
      content: content,
      actionsPadding: const EdgeInsets.all(0),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: wp(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorLight),
              child: TextButton(
                onPressed: onPressedNo!,
                child: Text(Tkey.no.tr,
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor)),
              ),
            ),
            Container(
              width: wp(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: COLOR_PRIMARY),
              child: TextButton(
                onPressed: onPressedYes!,
                child: Text(
                  Tkey.yes.tr,
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: hp(2),
        )
      ],
    );
  }
}
