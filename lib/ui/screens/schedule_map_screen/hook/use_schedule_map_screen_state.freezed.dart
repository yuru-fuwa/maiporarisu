// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'use_schedule_map_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScheduleMapScreenState {
  DateTime get dateTime => throw _privateConstructorUsedError;
  TimeOfDay get timeOfDay => throw _privateConstructorUsedError;
  void Function(DateTime) get handleDateTimeState =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleMapScreenStateCopyWith<ScheduleMapScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleMapScreenStateCopyWith<$Res> {
  factory $ScheduleMapScreenStateCopyWith(ScheduleMapScreenState value,
          $Res Function(ScheduleMapScreenState) then) =
      _$ScheduleMapScreenStateCopyWithImpl<$Res, ScheduleMapScreenState>;
  @useResult
  $Res call(
      {DateTime dateTime,
      TimeOfDay timeOfDay,
      void Function(DateTime) handleDateTimeState});
}

/// @nodoc
class _$ScheduleMapScreenStateCopyWithImpl<$Res,
        $Val extends ScheduleMapScreenState>
    implements $ScheduleMapScreenStateCopyWith<$Res> {
  _$ScheduleMapScreenStateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleMapScreenStateImplCopyWith<$Res>
    implements $ScheduleMapScreenStateCopyWith<$Res> {
  factory _$$ScheduleMapScreenStateImplCopyWith(
          _$ScheduleMapScreenStateImpl value,
          $Res Function(_$ScheduleMapScreenStateImpl) then) =
      __$$ScheduleMapScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime dateTime,
      TimeOfDay timeOfDay,
      void Function(DateTime) handleDateTimeState});
}

/// @nodoc
class __$$ScheduleMapScreenStateImplCopyWithImpl<$Res>
    extends _$ScheduleMapScreenStateCopyWithImpl<$Res,
        _$ScheduleMapScreenStateImpl>
    implements _$$ScheduleMapScreenStateImplCopyWith<$Res> {
  __$$ScheduleMapScreenStateImplCopyWithImpl(
      _$ScheduleMapScreenStateImpl _value,
      $Res Function(_$ScheduleMapScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? timeOfDay = null,
    Object? handleDateTimeState = null,
  }) {
    return _then(_$ScheduleMapScreenStateImpl(
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
    ));
  }
}

/// @nodoc

class _$ScheduleMapScreenStateImpl extends _ScheduleMapScreenState {
  const _$ScheduleMapScreenStateImpl(
      {required this.dateTime,
      required this.timeOfDay,
      required this.handleDateTimeState})
      : super._();

  @override
  final DateTime dateTime;
  @override
  final TimeOfDay timeOfDay;
  @override
  final void Function(DateTime) handleDateTimeState;

  @override
  String toString() {
    return 'ScheduleMapScreenState(dateTime: $dateTime, timeOfDay: $timeOfDay, handleDateTimeState: $handleDateTimeState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleMapScreenStateImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.handleDateTimeState, handleDateTimeState) ||
                other.handleDateTimeState == handleDateTimeState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dateTime, timeOfDay, handleDateTimeState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleMapScreenStateImplCopyWith<_$ScheduleMapScreenStateImpl>
      get copyWith => __$$ScheduleMapScreenStateImplCopyWithImpl<
          _$ScheduleMapScreenStateImpl>(this, _$identity);
}

abstract class _ScheduleMapScreenState extends ScheduleMapScreenState {
  const factory _ScheduleMapScreenState(
          {required final DateTime dateTime,
          required final TimeOfDay timeOfDay,
          required final void Function(DateTime) handleDateTimeState}) =
      _$ScheduleMapScreenStateImpl;
  const _ScheduleMapScreenState._() : super._();

  @override
  DateTime get dateTime;
  @override
  TimeOfDay get timeOfDay;
  @override
  void Function(DateTime) get handleDateTimeState;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleMapScreenStateImplCopyWith<_$ScheduleMapScreenStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
