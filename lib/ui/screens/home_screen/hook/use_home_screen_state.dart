import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
