import 'package:community_app/pages/add_members/add_members_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/responsive.dart';
import '../../translation/key.dart';
import '../../constants/textstyle.dart';
import '../../constants/validation.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_buttom.dart';
import '../../widget/custom_textformfield.dart';
import '../../widget/international_phone_field.dart';

class AddMembersPage extends StatelessWidget {
  const AddMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMembersController>(
        init: AddMembersController(),
        initState: (_) {},
        builder: (controller) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Customappbarwidget(
              leadingonTap: () {
                Get.back();
              },
              leadingchild: Padding(
                padding: EdgeInsets.only(left: wp(5), top: hp(2)),
                child: SvgPicture.asset("assets/icons/ic_cancle.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColorDark, BlendMode.srcIn)),
              ),
              leadingWidth: wp(9),
              title: Tkey.addmemberstext.tr,
              fontSize: 22,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: wp(4), right: wp(4)),
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: hp(3)),
                      Text(Tkey.firstnametext.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.firstnameController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.enteryourFirstname.tr,
                        validationfunction: nameValidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.lastnametext.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.lastnameController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.enteryourlastname.tr,
                        validationfunction: nameValidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.mobilenumber.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      Obx(
                        () => Internationalphonefield(
                          isDiaplayError: controller.numberfield.value,
                          hintText: Tkey.enteryourmobileno.tr,
                          controller: controller.mobilenoController,
                          textInputAction: TextInputAction.next,
                          onChanged: (p0) {
                            controller.mobilenoController.text == ""
                                ? controller.numberfield.value = true
                                : controller.numberfield.value = false;
                          },
                        ),
                      ),
                      Obx(
                        () => controller.numberfield.value
                            ? Padding(
                                padding: EdgeInsets.only(left: wp(4)),
                                child: Text(
                                  Tkey.mobilenumberisrequired.tr,
                                  style: smallRegularTextStyle.copyWith(
                                      fontSize: 11, color: Colors.red.shade800),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.relationwithmainMember.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.relationController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.enteryourrelation.tr,
                        validationfunction: relationvalidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.birthdate.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child:
                              SvgPicture.asset("assets/icons/ic_calendar.svg"),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        textEditingController: controller.birthdateController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.selectyourbirthdate.tr,
                        validationfunction: isValidDateOfBirth,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            helpText: 'Select a date',
                            cancelText: 'Cancel',
                            confirmText: 'Select',
                            errorFormatText: 'Invalid date format',
                            errorInvalidText: 'Invalid date',
                            fieldLabelText: 'Date',
                            fieldHintText: 'YYYY-MM-DD',
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Theme.of(context).primaryColor,
                                  hintColor: Theme.of(context).primaryColor,
                                  colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor),
                                  buttonTheme: const ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            controller.birthdateController.text = formattedDate;
                          }
                        },
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.education.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.educationController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.enteryoureducation.tr,
                        validationfunction: educationvalidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(Tkey.maritalStatus.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: "Married",
                            groupValue: controller.marital,
                            onChanged: (value) {
                              controller.showError.value = false;
                              controller.marital = "Married";
                              controller.update();
                            },
                          ),
                          Text(Tkey.married.tr),
                          SizedBox(width: wp(15)),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            value: "Unmarried",
                            groupValue: controller.marital,
                            onChanged: (value) {
                              controller.showError.value = false;
                              controller.marital = "Unmarried";
                              controller.update();
                            },
                          ),
                          Text(Tkey.unmarried.tr),
                        ],
                      ),
                      Obx(() {
                        if (controller.showError.value) {
                          return Padding(
                            padding: EdgeInsets.only(left: wp(4)),
                            child: Text(
                              Tkey.pleaseselectamaritalstatus.tr,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        } else {
                          return SizedBox(height: hp(2));
                        }
                      }),
                      Text(Tkey.currentlyLivingat.tr,
                          style: titleTextStyle.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).primaryColorDark)),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        textInputAction: TextInputAction.done,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 15),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.locationController,
                        customobscuretext: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: Tkey.enteryourlocation.tr,
                        validationfunction: locationvalidator,
                      ),
                      SizedBox(height: hp(4)),
                      GestureDetector(
                          onTap: () {
                            controller.addMember();
                          },
                          child: Custombuttom(
                            child: controller.loading
                                ? CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)
                                : Text(
                                    Tkey.addMember.tr,
                                    style: titleTextStyle.copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ),
                          )),
                      SizedBox(
                        height: hp(3),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
