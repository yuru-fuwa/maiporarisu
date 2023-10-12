// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'use_home_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeScreenState {
  DateTime get dateTime => throw _privateConstructorUsedError;
  TimeOfDay get timeOfDay => throw _privateConstructorUsedError;
  void Function(DateTime) get handleDateTimeState =>
      throw _privateConstructorUsedError;
  void Function(TimeOfDay) get handleTimeOfDayState =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
          HomeScreenState value, $Res Function(HomeScreenState) then) =
      _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call(
      {DateTime dateTime,
      TimeOfDay timeOfDay,
      void Function(DateTime) handleDateTimeState,
      void Function(TimeOfDay) handleTimeOfDayState});
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? timeOfDay = null,
    Object? handleDateTimeState = null,
    Object? handleTimeOfDayState = null,
  }) {
    return _then(_value.copyWith(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      handleDateTimeState: null == handleDateTimeState
          ? _value.handleDateTimeState
          : handleDateTimeState // ignore: cast_nullable_to_non_nullable
              as void Function(DateTime),
      handleTimeOfDayState: null == handleTimeOfDayState
          ? _value.handleTimeOfDayState
          : handleTimeOfDayState // ignore: cast_nullable_to_non_nullable
              as void Function(TimeOfDay),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeScreenStateImplCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$HomeScreenStateImplCopyWith(_$HomeScreenStateImpl value,
          $Res Function(_$HomeScreenStateImpl) then) =
      __$$HomeScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime dateTime,
      TimeOfDay timeOfDay,
      void Function(DateTime) handleDateTimeState,
      void Function(TimeOfDay) handleTimeOfDayState});
}

/// @nodoc
class __$$HomeScreenStateImplCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$HomeScreenStateImpl>
    implements _$$HomeScreenStateImplCopyWith<$Res> {
  __$$HomeScreenStateImplCopyWithImpl(
      _$HomeScreenStateImpl _value, $Res Function(_$HomeScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? timeOfDay = null,
    Object? handleDateTimeState = null,
    Object? handleTimeOfDayState = null,
  }) {
    return _then(_$HomeScreenStateImpl(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      handleDateTimeState: null == handleDateTimeState
          ? _value.handleDateTimeState
          : handleDateTimeState // ignore: cast_nullable_to_non_nullable
              as void Function(DateTime),
      handleTimeOfDayState: null == handleTimeOfDayState
          ? _value.handleTimeOfDayState
          : handleTimeOfDayState // ignore: cast_nullable_to_non_nullable
              as void Function(TimeOfDay),
    ));
  }
}

/// @nodoc

class _$HomeScreenStateImpl extends _HomeScreenState {
  const _$HomeScreenStateImpl(
      {required this.dateTime,
      required this.timeOfDay,
      required this.handleDateTimeState,
      required this.handleTimeOfDayState})
      : super._();

  @override
  final DateTime dateTime;
  @override
  final TimeOfDay timeOfDay;
  @override
  final void Function(DateTime) handleDateTimeState;
  @override
  final void Function(TimeOfDay) handleTimeOfDayState;

  @override
  String toString() {
    return 'HomeScreenState(dateTime: $dateTime, timeOfDay: $timeOfDay, handleDateTimeState: $handleDateTimeState, handleTimeOfDayState: $handleTimeOfDayState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeScreenStateImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.handleDateTimeState, handleDateTimeState) ||
                other.handleDateTimeState == handleDateTimeState) &&
            (identical(other.handleTimeOfDayState, handleTimeOfDayState) ||
                other.handleTimeOfDayState == handleTimeOfDayState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime, timeOfDay,
      handleDateTimeState, handleTimeOfDayState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      __$$HomeScreenStateImplCopyWithImpl<_$HomeScreenStateImpl>(
          this, _$identity);
}

abstract class _HomeScreenState extends HomeScreenState {
  const factory _HomeScreenState(
          {required final DateTime dateTime,
          required final TimeOfDay timeOfDay,
          required final void Function(DateTime) handleDateTimeState,
          required final void Function(TimeOfDay) handleTimeOfDayState}) =
      _$HomeScreenStateImpl;
  const _HomeScreenState._() : super._();

  @override
  DateTime get dateTime;
  @override
  TimeOfDay get timeOfDay;
  @override
  void Function(DateTime) get handleDateTimeState;
  @override
  void Function(TimeOfDay) get handleTimeOfDayState;
  @override
  @JsonKey(ignore: true)
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
