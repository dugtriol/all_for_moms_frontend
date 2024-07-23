import 'package:json_annotation/json_annotation.dart';

part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  final int id;
  final String title;

  final String description;

  @JsonKey(name: "start_date", fromJson: _parseDateFromString)
  final DateTime? startDate;

  @JsonKey(name: "end_date", fromJson: _parseDateFromString)
  final DateTime? endDate;

  @JsonKey(name: "is_recurring")
  final bool isRecurring;

  @JsonKey(name: "recurrence_interval")
  final int? recurrenceInterval;

  @JsonKey(name: "task_getter")
  final int taskGetter;

  @JsonKey(name: "task_setter")
  final int taskSetter;

  @JsonKey(name: "reward_point")
  final int rewardPoint;

  @JsonKey(name: "is_completed")
  final bool isCompleted;

  TaskResponse(
      {required this.id,
      required this.title,
      required this.description,
      required this.endDate,
      required this.isRecurring,
      required this.recurrenceInterval,
      required this.rewardPoint,
      required this.startDate,
      required this.taskGetter,
      required this.isCompleted,
      required this.taskSetter});

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}
