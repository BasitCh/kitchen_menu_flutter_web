import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_book/widgets_book.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerGlobalKey =
    GlobalKey();

int calculateAge(DateTime birthDate) {
  final currentDate = DateTime.now();
  var age = currentDate.year - birthDate.year;
  final month1 = currentDate.month;
  final month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    final day1 = currentDate.day;
    final day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

String? validateEmail(String? val) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (val == null || val.isEmpty) {
    return 'Please enter your email address';
  } else if (!RegExp(emailRegex).hasMatch(val)) {
    return 'The email you entered is invalid';
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
  var patttern = r'(^(?:[+0]9)?[0-9]{6,10}$)';
  final regExp = RegExp(patttern);
  if (value != null && value.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value!)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? emptyValidation(String? value, String validationMessage) {
  if (value != null && value.isEmpty) {
    return validationMessage;
  }
  return null;
}

List<String> categories = [
  'Breakfast',
  'Lunch',
  'Dinner',
];

DateTime? dateFromJson(Timestamp? val) => val == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);

Timestamp? dateToJson(DateTime? time) => time == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

FilteringTextInputFormatter decimalInputFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'));

List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];

(DateTime date1, DateTime date2) calculateMenuDateRange({DateTime? dateTime}) {
  var now = DateTime.now();
  var today = dateTime ?? DateTime(now.year, now.month, now.day);
  var startDateTime = today;
  var endDateTime = DateTime(today.year, today.month, today.day + 4);
  var weekDay = today.weekday;
  switch (weekDay) {
    case 1:
      endDateTime = DateTime(today.year, today.month, today.day + 4);
      break;
    case 2:
      startDateTime = DateTime(today.year, today.month, today.day - 1);
      endDateTime = DateTime(today.year, today.month, today.day + 3);
      break;
    case 3:
      startDateTime = DateTime(today.year, today.month, today.day - 2);
      endDateTime = DateTime(today.year, today.month, today.day + 2);
      break;
    case 4:
      startDateTime = DateTime(today.year, today.month, today.day - 3);
      endDateTime = DateTime(today.year, today.month, today.day + 1);
      break;
    case 5:
      startDateTime = DateTime(today.year, today.month, today.day - 4);
      endDateTime = DateTime(today.year, today.month, today.day);
      break;
    case 6:
      startDateTime = DateTime(today.year, today.month, today.day - 5);
      endDateTime = DateTime(today.year, today.month, today.day - 1);
      break;
    case 7:
      startDateTime = DateTime(today.year, today.month, today.day - 6);
      endDateTime = DateTime(today.year, today.month, today.day - 2);
      break;
    default:
      break;
  }
  return (startDateTime, endDateTime);
}

DateTime getMealPlanDate(DateTime date, String day) {
  if (day.toLowerCase() == 'monday') {
    return date;
  } else if (day.toLowerCase() == 'tuesday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 1,
    );
  } else if (day.toLowerCase() == 'wednesday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 2,
    );
  } else if (day.toLowerCase() == 'thursday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 3,
    );
  } else if (day.toLowerCase() == 'friday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 4,
    );
  } else if (day.toLowerCase() == 'saturday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 5,
    );
  } else if (day.toLowerCase() == 'sunday') {
    date = DateTime(
      date.year,
      date.month,
      date.day + 6,
    );
  }
  return date;
}

String removeZero(String money) {
  var response = money;
  if (!money.contains('/') && money.contains('.')) {
    if (money.toString().split(".").length > 0) {
      var decmialPoint = money.toString().split(".")[1];
      if (decmialPoint == "0") {
        response = response.split(".0").join("");
      }
    } else {
      double.parse(money).toStringAsFixed(1);
    }
  }

  return response;
}

DateTime getFirstMonday(DateTime dateTime) {
  DateTime date =
      dateTime.addCalendarDays((7 - (dateTime.weekday - DateTime.monday)) % 7);
  return date;
}

// final Shader buttonGradient = const LinearGradient(
//   colors: <Color>[
//     MenuMasterColors.buttonPrimary,
//     MenuMasterColors.buttonPrimary,
//   ],
// ).createShader(const Rect.fromLTRB(50.0, 50.0, 200.0, 70.0));

//
// DateTime? dateFromJson(Timestamp? val) => val == null
//     ? null
//     : DateTime.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch);
//
// Timestamp? dateToJson(DateTime? time) => time == null
//     ? null
//     : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
