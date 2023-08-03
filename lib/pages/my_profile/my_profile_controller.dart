import 'dart:developer';
import 'dart:io';
import 'package:community_app/data/repositories/account_setting_Repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Value;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../constants/functions.dart';
import '../../translation/key.dart';
import 'model/profile_model.dart';

class MyprofileController extends GetxController {
  final AccountSettingRepository? accountSettingRepository;
  MyprofileController({this.accountSettingRepository});
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RxString selectedCountryCode = "".obs;
  RxString countryshortcode = ''.obs;
  String? imageurl;
  ProfileData? listofprofile;
  File? imagepicker;
  RxBool numberfield = false.obs;
  String? updateimage;
  String? marital;
  RxBool showError = false.obs;
  bool loading = false;

  @override
  void onInit() async {
    super.onInit();

    getProfile();
  }

  // update image
  Future pickImage(ImageSource imageType) async {
    try {
      final pick = await ImagePicker().pickImage(source: imageType);
      if (pick != null) {
        final croppedFile = await ImageCropper().cropImage(
          maxHeight: 300,
          maxWidth: 300,
          sourcePath: pick.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        );
        if (croppedFile != null) {
          File file = File(croppedFile.path.toString());
          imagepicker = file;
          imageurl = imagepicker?.path;
          log("imageurl:$imageurl");
          update();
        }
      }
    } catch (e) {
      Error;
    }
  }

  getProfile() async {
    await accountSettingRepository?.getprofile().then((response) async {
      loading = true;
      update();
      if (response != null) {
        if (response.statusCode == 200) {
          Profilemodel modelList = Profilemodel.fromJson(response.data);
          listofprofile = modelList.data;
          imageurl = listofprofile?.profilePic?.split("?")[0] ?? "";
          firstnameController.text = listofprofile?.firstName ?? "";
          lastnameController.text = listofprofile?.lastName ?? "";
          birthdateController.text = listofprofile?.birthdate ?? "";
          relationController.text = listofprofile?.relationWithMainMember ?? "";
          educationController.text = listofprofile?.education ?? "";
          marital = getMaritalStatus(listofprofile?.maritalStatus);
          locationController.text = listofprofile?.currentlyLivingAt ?? "";
          // final phoneNumberUtil = PhoneNumberUtil();
          phonenumberController.text = listofprofile?.mobileNumber ?? "";
          // final parsedNumber = await phoneNumberUtil.parse("+$phoneNumber");
          // selectedCountryCode.value = parsedNumber.countryCode.toString();
          // phonenumberController.text = parsedNumber.nationalNumber;
          // countryshortcode.value = parsedNumber.regionCode.toString();

          update();
        } else {
          log("response.statusCode: ${response.statusCode}");
        }
      } else {
        log("object");
      }
      update();
    });
  }

  putprofile() async {
    final Map<String, dynamic> jsonData = {
      'first_name': firstnameController.text,
      'last_name': lastnameController.text,
      'mobile_number':
          "+${selectedCountryCode.value}${phonenumberController.text}",
      'email': "",
      'relationWithMainMember': relationController.text,
      'education': educationController.text,
      'currentlyLivingAt': lastnameController.text,
      'maritalStatus': marital,
      'birthdate': birthdateController.text
    };

    if (imagepicker != null) {
      MediaType mediaType;
      String fileType =
          imagepicker!.path.substring(imagepicker!.path.lastIndexOf(".") + 1);

      bool ifHEICFileType = checkForHEICFileType(imagepicker!.path);
      if (ifHEICFileType) {
        mediaType = MediaType("image", "HEIC");
      } else {
        mediaType = MediaType(getFileType(imagepicker!.path), fileType);
      }
      log(imagepicker!.path);

      jsonData.addAll({
        'profile_pic': await MultipartFile.fromFile(imagepicker!.path,
            filename: imagepicker!.path.split("/").last, contentType: mediaType)
      });
    }
    if (formkey.currentState!.validate() &&
        (marital != null) &&
        phonenumberController.text.isNotEmpty) {
      numberfield.value = false;

      if (marital != null) {
        showError.value = false;
        FormData formData = FormData.fromMap(jsonData);
        accountSettingRepository
            ?.putprofile(jsonData: formData)
            .then((response) {
          if (response != null) {
            if (formkey.currentState!.validate()) {
              if (response.statusCode == 200) {
                getProfile();
                getSnackBar(Tkey.profildataadd.tr, SNACK.SUCCESS);
              } else {}
            }
          }
        });
      }
    } else if (marital == null && phonenumberController.text.isEmpty) {
      numberfield.value = true;
      showError.value = true;
    }
  }

  bool checkForHEICFileType(String path) {
    String fileName = path.split("/").last;
    String fileType = fileName.split(".").last;
    if (fileType == "HEIC") {
      return true;
    } else {
      return false;
    }
  }

  String getFileType(String path) {
    String? mimeType = lookupMimeType(path);
    String result = mimeType!.substring(0, mimeType.indexOf('/'));
    return result;
  }
}
