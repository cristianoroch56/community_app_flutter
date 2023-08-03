import 'dart:developer';
import 'package:community_app/constants/responsive.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/constants/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';
import '../../constants/textstyle.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_buttom.dart';
import '../../widget/custom_textformfield.dart';
import '../../widget/international_phone_field.dart';
import '../../widget/upload_image.dart';
import 'my_profile_controller.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyprofileController>(
        init: MyprofileController(),
        initState: (_) {},
        builder: (controller) {
          log("selectedCountryCode : ${controller.selectedCountryCode.value}");
          log("countryshortcode : ${controller.countryshortcode.value}");
          return Scaffold(
            backgroundColor: COLOR_WHITE,
            appBar: Customappbarwidget(
              leadingonTap: () {
                Get.back();
              },
              leadingchild: Padding(
                padding: EdgeInsets.only(left: wp(5), top: hp(2)),
                child: SvgPicture.asset("assets/icons/ic_back.svg",
                    height: hp(2.4),
                    width: wp(2.4),
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColorDark, BlendMode.srcIn)),
              ),
              leadingWidth: wp(14),
              elevation: 0.0,
              title: Tkey.profile.tr,
              fontSize: 22,
            ),
            body: Padding(
              padding: EdgeInsets.only(left: wp(6), right: wp(6)),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: hp(3)),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: hp(15),
                              width: wp(30),
                              decoration: BoxDecoration(
                                  color: COLOR_WHITE,
                                  border: Border.all(
                                      color: Colors.white, width: wp(2)),
                                  borderRadius:
                                      BorderRadius.circular(dp(context, 12))),
                              child: controller.imagepicker == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          dp(context, 12)),
                                      child: Image.network(
                                        controller.imageurl.toString(),
                                        height: hp(5),
                                        width: wp(10),
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) {
                                            return child;
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(25),
                                            child: CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: hp(15),
                                            width: wp(30),
                                            decoration: BoxDecoration(
                                                color: COLOR_LIGHTGRAY,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        dp(context, 12))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: SvgPicture.asset(
                                                "assets/icons/ic_man.svg",
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          dp(context, 12)),
                                      child: Image.file(
                                        controller.imagepicker!,
                                        height: hp(5),
                                        width: wp(10),
                                        fit: BoxFit.fill,
                                      )),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            Uploadimage(onTapCamera: () {
                                              controller.pickImage(
                                                  ImageSource.camera);
                                              Get.back();
                                            }, onTapGallery: () {
                                              controller.pickImage(
                                                  ImageSource.gallery);
                                              Get.back();
                                            }));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(dp(context, 15)),
                                        ),
                                        color: Theme.of(context).primaryColor),
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_camera.svg"),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: hp(4)),
                      Text(
                        Tkey.basicdetails.tr,
                        style: titleTextStyle.copyWith(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 16),
                      ),
                      SizedBox(height: hp(2)),
                      Text(
                        Tkey.firstnametext.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      CustomTextFormField(
                          validationfunction: nameValidator,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.text,
                          textEditingController: controller.firstnameController,
                          customobscuretext: true,
                          border: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(),
                          hintText: Tkey.enteryourFirstname.tr,
                          prefixIcon: SizedBox(
                            height: hp(1),
                            width: wp(1),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/ic_man.svg"),
                                const VerticalDivider(
                                  indent: 12,
                                  endIndent: 12,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: hp(2)),
                      Text(
                        Tkey.lastnametext.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      CustomTextFormField(
                          validationfunction: nameValidator,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.text,
                          textEditingController: controller.lastnameController,
                          customobscuretext: true,
                          border: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(),
                          hintText: Tkey.enteryourlastname.tr,
                          prefixIcon: SizedBox(
                            height: hp(1),
                            width: wp(1),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/ic_man.svg"),
                                VerticalDivider(
                                  indent: 12,
                                  endIndent: 12,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: hp(2)),
                      Text(
                        Tkey.phonenumberprofile.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      Obx(() => Internationalphonefield(
                            focusedBorder: (controller.numberfield.value
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 1),
                                    borderRadius: BorderRadius.circular(8))
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.4),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            border: (controller.numberfield.value
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 1),
                                    borderRadius: BorderRadius.circular(8))
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.4),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            errorBorder: (controller.numberfield.value
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 1),
                                    borderRadius: BorderRadius.circular(8))
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.4),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            enabledBorder: (controller.numberfield.value
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red.shade800, width: 1),
                                    borderRadius: BorderRadius.circular(8))
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColorDark
                                            .withOpacity(0.4),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            hintText: Tkey.enterMobileNumber.tr,
                            controller: controller.phonenumberController,
                            initialCountryCode:
                                controller.countryshortcode.value,
                            onChanged: (phone) {
                              controller.phonenumberController.text =
                                  phone.number;
                              controller.update();
                            },
                            onCountryChanged: (countryCode) {
                              controller.selectedCountryCode.value =
                                  countryCode.dialCode;
                              controller.countryshortcode.value =
                                  countryCode.code;
                              controller.update();
                            },
                          )),
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
                      Text(
                        Tkey.relationwithmainMember.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        prefixIcon: SizedBox(
                          height: hp(1),
                          width: wp(1),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/3x/relationship.png",
                                scale: dp(context, 6),
                              ),
                              VerticalDivider(
                                indent: 12,
                                endIndent: 12,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ],
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.relationController,
                        customobscuretext: true,
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        hintText: Tkey.enteryourrelation.tr,
                        validationfunction: relationvalidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(
                        Tkey.birthdate.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        prefixIcon: SizedBox(
                          height: hp(1),
                          width: wp(1),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/ic_calendar.svg"),
                              VerticalDivider(
                                indent: 12,
                                endIndent: 12,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ],
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        textEditingController: controller.birthdateController,
                        customobscuretext: true,
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
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
                      Text(
                        Tkey.education.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        prefixIcon: SizedBox(
                          height: hp(1),
                          width: wp(1),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/3x/education.png",
                                scale: dp(context, 11),
                              ),
                              VerticalDivider(
                                indent: 12,
                                endIndent: 12,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ],
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 12),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.educationController,
                        customobscuretext: true,
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        hintText: Tkey.enteryoureducation.tr,
                        validationfunction: educationvalidator,
                      ),
                      SizedBox(height: hp(2)),
                      Text(
                        Tkey.maritalStatus.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
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
                      controller.showError.value
                          ? Padding(
                              padding: EdgeInsets.only(left: wp(4)),
                              child: Text(
                                Tkey.pleaseselectamaritalstatus.tr,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : SizedBox(height: hp(2)),
                      Text(
                        Tkey.currentlyLivingat.tr,
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      SizedBox(height: hp(1.5)),
                      CustomTextFormField(
                        prefixIcon: SizedBox(
                          height: hp(1),
                          width: wp(1),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/3x/living_at.png",
                                scale: dp(context, 11),
                              ),
                              VerticalDivider(
                                indent: 12,
                                endIndent: 12,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ],
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 15),
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        textEditingController: controller.locationController,
                        customobscuretext: true,
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        hintText: Tkey.enteryourlocation.tr,
                        validationfunction: locationvalidator,
                      ),
                      SizedBox(height: hp(4)),
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              controller.update();
                              controller.putprofile();
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: wp(20), right: wp(20)),
                              child: Custombuttom(
                                child: Text(Tkey.save.tr,
                                    style: textMediumStyle.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
