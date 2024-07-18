// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      endDate: TaskResponse._parseDateFromString(json['end_date'] as String?),
      isRecurring: json['is_recurring'] as bool,
      recurrenceInterval: (json['recurrence_interval'] as num?)?.toInt(),
      rewardPoint: (json['reward_point'] as num).toInt(),
      startDate:
          TaskResponse._parseDateFromString(json['start_date'] as String?),
      taskGetter: (json['task_getter'] as num).toInt(),
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'is_recurring': instance.isRecurring,
      'recurrence_interval': instance.recurrenceInterval,
      'task_getter': instance.taskGetter,
      'reward_point': instance.rewardPoint,
      'is_completed': instance.isCompleted,
    };
