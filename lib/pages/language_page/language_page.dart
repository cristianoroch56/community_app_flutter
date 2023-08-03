import 'package:community_app/constants/style.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/pages/language_page/language_controller.dart';
import 'package:community_app/constants/textstyle.dart';
import 'package:community_app/routes/app_routes.dart';
import 'package:community_app/widget/custom_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/responsive.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: Form(
            key: controller.formkey,
            child: Column(
              children: [
                SizedBox(height: hp(4)),
                Image.asset('assets/icons/2x/top_background_light.png'),
                Image.asset('assets/icons/1.5x/languages.png', height: 80),
                SizedBox(height: hp(3)),
                Text(Tkey.language.tr,
                    style: titleTextStyle.copyWith(
                        fontSize: 20,
                        color: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.8))),
                SizedBox(height: hp(1)),
                Text(Tkey.pleaseChooseLanguage.tr,
                    style: textMediumStyle.copyWith(
                        color: const Color(0xFF999999))),
                SizedBox(height: hp(3)),
                Obx(
                  () => SizedBox(
                    width: wp(48),
                    child: DropdownButtonFormField(
                        value: controller.language.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        isExpanded: true,
                        validator: (value) {
                          if (value == Tkey.selectLanguage.tr) {
                            return Tkey.pleaseChooseLanguage.tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.6),
                                    width: 1)),
                            hintText: Tkey.selectLanguage.tr,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.24),
                                    width: 1))),
                        style: textMediumStyle.copyWith(
                            fontFamily: fontMedium,
                            color: Theme.of(context).primaryColorDark),
                        icon: SvgPicture.asset('assets/icons/ic_languages.svg'),
                        elevation: 1,
                        items: controller.languages.map((String languages) {
                          return DropdownMenuItem(
                              value: languages, child: Text(languages));
                        }).toList(),
                        onChanged: (value) {
                          controller.setLanguage(value.toString());
                        }),
                  ),
                ),
                SizedBox(height: hp(4)),
                CustomNextButton(
                  radius: 16,
                  onTap: () {
                    if (controller.formkey.currentState!.validate()) {
                      Get.offAndToNamed(ROUTE_LOGIN_PAGE);
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
