// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      description: json['description'] as String,
      endDate: Task._parseDateFromString(json['end_date'] as String?),
      isRecurring: json['is_recurring'] as bool,
      recurrenceInterval: (json['recurrence_interval'] as num).toInt(),
      rewardPoint: (json['reward_point'] as num).toInt(),
      startDate: Task._parseDateFromString(json['start_date'] as String?),
      taskGetter: (json['task_getter'] as num).toInt(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'is_recurring': instance.isRecurring,
      'recurrence_interval': instance.recurrenceInterval,
      'task_getter': instance.taskGetter,
      'reward_point': instance.rewardPoint,
    };
