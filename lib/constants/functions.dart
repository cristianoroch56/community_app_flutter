// ignore_for_file: constant_identifier_names

import 'package:community_app/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

int getTimeDifferenceInSeconds(DateTime dateTime) {
  DateTime currentDateTime = DateTime.now();
  Duration difference = currentDateTime.difference(dateTime);
  return difference.inSeconds.abs();
}

String showTimeDifference(int timeDifferenceInSeconds) {
  int days = timeDifferenceInSeconds ~/ (24 * 3600);
  int hours = (timeDifferenceInSeconds % (24 * 3600)) ~/ 3600;
  int minutes = ((timeDifferenceInSeconds % 3600) ~/ 60);
  int seconds = timeDifferenceInSeconds % 60;

  if (days > 0) {
    if (days == 1) {
      return "1 day ago";
    }
    return '$days days ago';
  } else if (hours > 0) {
    if (hours == 1) {
      return "1 hour ago";
    }
    return '$hours hours ago';
  } else if (minutes > 0) {
    if (minutes == 1) {
      return "1 minute ago";
    }
    return '$minutes minutes ago';
  } else {
    if (seconds == 1) {
      return "1 second ago";
    }
    return '$seconds seconds ago';
  }
}

String getTimeDuration(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int seconds = getTimeDifferenceInSeconds(dateTime);
  String message = showTimeDifference(seconds);
  return message;
}

//to display date time in event details screen
String formatEventDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat formatter = DateFormat('dd MMMM, yyyy hh:mm a');
  String formattedDateTime = formatter.format(dateTime);
  return formattedDateTime;
}

//to display date time in message screen
String formatThreadDateTime(String dateTimeString) {
  DateTime dateTime =
      DateTime.parse(dateTimeString).add(const Duration(hours: 5, minutes: 30));
  DateFormat formatter = DateFormat('hh:mm a');
  String formattedDateTime = formatter.format(dateTime);
  return formattedDateTime;
}

//to display date tag in chat page
String getDateTimeTag(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  final now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final previous = now.subtract(const Duration(days: 1));
  if (dateTime.isAfter(now)) {
    return "Today";
  } else if (dateTime.isAfter(previous)) {
    return "Yesterday";
  } else if (dateTime.isAfter(now.subtract(const Duration(days: 7))) &&
      dateTime.isBefore(now.subtract(const Duration(days: 1)))) {
    final weekdayFormat = DateFormat('EEEE');
    return weekdayFormat.format(dateTime);
  } else {
    final dateFormat = DateFormat('d MMMM, y');
    return dateFormat.format(dateTime);
  }
}

//live status for event card
bool getLiveStatus(String eventDateString, String eventDurationString) {
  DateTime eventDate = DateTime.parse(eventDateString);
  DateTime eventDuration = DateTime.parse(eventDurationString);
  DateTime currDateTime = DateTime.now();
  if (currDateTime.isBefore(eventDuration) && currDateTime.isAfter(eventDate)) {
    return true;
  }
  return false;
}

String formatDate(String dateString) {
  DateTime utcTime = DateTime.parse(dateString);
  DateTime localTime = utcTime.toLocal();
  String formattedTime = DateFormat('MMMM DD,yyyy').format(localTime);
  formattedTime = formattedTime.replaceFirstMapped(RegExp(r'(\d{2})'), (match) {
    String month = '';
    switch (match.group(1)) {
      case '01':
        month = 'Jan';
        break;
      case '02':
        month = 'Feb';
        break;
      case '03':
        month = 'Mar';
        break;
      case '04':
        month = 'Apr';
        break;
      case '05':
        month = 'May';
        break;
      case '06':
        month = 'Jun';
        break;
      case '07':
        month = 'Jul';
        break;
      case '08':
        month = 'Aug';
        break;
      case '09':
        month = 'Sep';
        break;
      case '10':
        month = 'Oct';
        break;
      case '11':
        month = 'Nov';
        break;
      case '12':
        month = 'Dec';
        break;
    }
    return month;
  });
  return formattedTime;
}

enum SNACK { SUCCESS, FAILURE }

getSnackBar(String message, SNACK type, {String? title}) {
  return Get.snackbar(
    title ?? '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == SNACK.SUCCESS ? Colors.green : Colors.red,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 10,
    colorText: Colors.white,
    titleText: Container(
      height: 0,
    ),
    messageText: Text(
      message,
      style: textMediumStyle.copyWith(
          fontWeight: FontWeight.normal, color: Colors.white),
    ),
    padding: const EdgeInsets.only(left: 20, top: 10, bottom: 18, right: 10),
    margin: const EdgeInsets.all(15),
  );
}

String getMaritalStatus(bool? isMarried) {
  if (isMarried!) {
    return "Married";
  } else if (!isMarried) {
    return "Unmarried";
  } else {
    return "";
  }
}
