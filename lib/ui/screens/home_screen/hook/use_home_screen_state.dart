import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'use_home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const HomeScreenState._();

  const factory HomeScreenState({
    required DateTime dateTime,
    required TimeOfDay timeOfDay,
    required void Function(DateTime) handleDateTimeState,
    required void Function(TimeOfDay) handleTimeOfDayState,
  }) = _HomeScreenState;

  String get displayDate {
    var formatter = DateFormat('yyyy年M月d日 (E)', 'ja_JP');
    return formatter.format(dateTime);
  }

  String get displayTime {
    var formatter = DateFormat('H:mm', 'ja_JP');
    return formatter.format(
      DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ),
    );
  }

  String get displayTimeDifference {
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
}

HomeScreenState useHomeScreenState({
  required DateTime dateTime,
  required TimeOfDay timeOfDay,
}) {
  final dateTimeState = useState(dateTime);
  final timeOfDayState = useState(timeOfDay);

  void handleDateTimeState(DateTime newDateTime) {
    dateTimeState.value = newDateTime;
  }

  void handleTimeOfDayState(TimeOfDay newTimeOfDay) {
    timeOfDayState.value = newTimeOfDay;
  }

  return HomeScreenState(
    dateTime: dateTimeState.value,
    timeOfDay: timeOfDayState.value,
    handleDateTimeState: handleDateTimeState,
    handleTimeOfDayState: handleTimeOfDayState,
  );
}
