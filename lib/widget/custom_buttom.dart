import 'package:flutter/material.dart';
import '../constants/responsive.dart';

class Custombuttom extends StatelessWidget {
  final Widget? child;
  const Custombuttom({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: hp(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Color(0xffD0658E),
              Color(0xffFB796B),
              Color(0xffFFA53D),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: child);
  }
}
