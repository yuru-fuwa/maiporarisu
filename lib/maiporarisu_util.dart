import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaiporarisuUtil {
  static String getTimeDifference(
    DateTime dateTime, {
    TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0),
  }) {
    var now = DateTime.now();
    var difference = dateTime
        .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute))
        .difference(now);
    var isNegative = difference.isNegative;
    
    if (difference.inDays.abs() >= 365) {
      var years = difference.inDays.abs() ~/ 365;
      return isNegative ? '$years年前' : '$years年後';
    } else if (difference.inDays.abs() >= 30) {
      var months = difference.inDays.abs() ~/ 30;
      return isNegative ? '$monthsヶ月前' : '$monthsヶ月後';
    } else if (difference.inDays.abs() >= 7) {
      var weeks = difference.inDays.abs() ~/ 7;
      return isNegative ? '$weeks週間前' : '$weeks週間後';
    } else if (difference.inDays.abs() > 0) {
      return isNegative
          ? '${difference.inDays.abs()}日前'
          : '${difference.inDays}日後';
    } else if (difference.inHours.abs() > 0) {
      return isNegative
          ? '${difference.inHours.abs()}時間前'
          : '${difference.inHours}時間後';
    } else if (difference.inMinutes.abs() > 0) {
      return isNegative
          ? '${difference.inMinutes.abs()}分前'
          : '${difference.inMinutes}分後';
    } else {
      return '現在';
    }
  }

  static String getTimeDisplay(DateTime dateTime) {
    var now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return getTimeDifference(dateTime);
    } else {
      return DateFormat('H:mm', 'ja_JP').format(dateTime);
    }
  }
}
