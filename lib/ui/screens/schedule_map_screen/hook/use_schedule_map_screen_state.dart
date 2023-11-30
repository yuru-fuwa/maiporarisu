import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'use_schedule_map_screen_state.freezed.dart';

@freezed
class ScheduleMapScreenState with _$ScheduleMapScreenState {
  const ScheduleMapScreenState._();

  const factory ScheduleMapScreenState({
    required DateTime dateTime,
    required TimeOfDay timeOfDay,
    required void Function(DateTime) handleDateTimeState,
  }) = _ScheduleMapScreenState;

  String get displayDate {
    var formatter = DateFormat('yyyy年M月d日(E)', 'ja_JP');
    return formatter.format(dateTime);
  }

  String get compareDate {
    var formatter = DateFormat('yyyy-MM-dd', 'ja_JP');
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

ScheduleMapScreenState useScheduleMapScreenState({
  required DateTime dateTime,
  required TimeOfDay timeOfDay,
}) {
  final dateTimeState = useState(dateTime);
  final timeOfDayState = useState(timeOfDay);

  void handleDateTimeState(DateTime newDateTime) {
    dateTimeState.value = newDateTime;
  }

  return ScheduleMapScreenState(
    dateTime: dateTimeState.value,
    timeOfDay: timeOfDayState.value,
    handleDateTimeState: handleDateTimeState,
  );
}
