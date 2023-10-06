// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskId: json['task_id'] as String,
      taskTime: json['task_time'] as String,
      taskName: json['task_name'] as String,
      taskCheck: json['task_check'] as bool,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'task_time': instance.taskTime,
      'task_name': instance.taskName,
      'task_check': instance.taskCheck,
    };
