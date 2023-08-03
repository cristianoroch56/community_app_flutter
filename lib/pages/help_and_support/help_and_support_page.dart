import 'package:community_app/pages/help_and_support/help_and_support_controller.dart';
import 'package:community_app/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/responsive.dart';
import '../../constants/style.dart';
import '../../translation/key.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_textformfield.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpAndSupportController>(
      init: HelpAndSupportController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: Customappbarwidget(
            title: Tkey.accountHelpSupport.tr,
            fontSize: 20,
            leadingchild: Padding(
              padding: EdgeInsets.only(left: wp(5), top: hp(2)),
              child: SvgPicture.asset("assets/icons/ic_back.svg",
                  height: hp(2.4),
                  width: wp(2.4),
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).primaryColorDark, BlendMode.srcIn)),
            ),
            leadingonTap: () {
              Get.back();
            },
            leadingWidth: wp(14),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Tkey.title.tr,
                          style: titleTextStyle.copyWith(
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1)),
                      CustomTextFormField(
                          validationfunction: (value) {
                            if (value!.isEmpty) {
                              return "Title can't be empty";
                            }
                            return null;
                          },
                          textEditingController: controller.titleController,
                          textInputAction: TextInputAction.next,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 15),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.24),
                                  width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          textCapitalization: TextCapitalization.none,
                          textInputType: TextInputType.text,
                          hintText: Tkey.enterTitle.tr,
                          hintStyle: textMediumStyle.copyWith(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2))),
                      SizedBox(height: hp(2)),
                      Text(Tkey.description.tr,
                          style: titleTextStyle.copyWith(
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1)),
                      CustomTextFormField(
                          validationfunction: (value) {
                            if (value!.isEmpty) {
                              return "Please enter some description";
                            }
                            return null;
                          },
                          textEditingController:
                              controller.descriptionController,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 15),
                          minLines: 8,
                          maxLines: 16,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.24),
                                  width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          textCapitalization: TextCapitalization.none,
                          textInputType: TextInputType.multiline,
                          hintText: Tkey.enterDescription.tr,
                          hintStyle: textMediumStyle.copyWith(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2))),
                      SizedBox(height: hp(4)),
                      InkWell(
                        onTap: () {
                          if (controller.formkey.currentState!.validate()) {
                            controller.update();
                            controller.sendHelpAndSupportFeedback(
                                controller.titleController.text.toString(),
                                controller.descriptionController.text
                                    .toString());
                          } else {
                            return;
                          }
                        },
                        child: Center(
                          child: Container(
                            height: hp(7),
                            width: wp(100),
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
                            child: Center(
                                child: controller.loading.value
                                    ? CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)
                                    : Text(Tkey.submit.tr,
                                        style: textMediumStyle.copyWith(
                                            color: Colors.white,
                                            fontFamily: fontMedium))),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
