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
