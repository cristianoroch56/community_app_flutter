import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomNoData extends StatelessWidget {
  final String iconaddress;
  const CustomNoData({
    super.key,
    required this.iconaddress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Lottie.asset(iconaddress)),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
