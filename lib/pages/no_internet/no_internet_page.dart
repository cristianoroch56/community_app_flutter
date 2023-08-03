import 'package:community_app/constants/responsive.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/no_internet/no_internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';
import '../../constants/textstyle.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<NoInternetController>(
        init: NoInternetController(),
        initState: (_) {},
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/1.5x/no_internet.png'),
                  Text(Tkey.ooops.tr,
                      style: titleTextStyle.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).primaryColorDark)),
                  SizedBox(height: hp(1)),
                  Text(Tkey.noInternetConnectionFound.tr,
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.5))),
                  Text(Tkey.checkYourConnection.tr,
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.5))),
                  SizedBox(height: hp(4)),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: hp(6),
                        width: wp(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              secondaryColor1,
                              secondaryColor2,
                              Theme.of(context).primaryColor
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.checkInternetConnectivity();
                          },
                          child: Center(
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)
                                : Text(
                                    Tkey.tryAgain.tr,
                                    style: textMediumStyle.copyWith(
                                        color: Colors.white,
                                        fontFamily: fontMedium),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
