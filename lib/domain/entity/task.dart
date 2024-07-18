import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
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

  @JsonKey(name: "reward_point")
  final int rewardPoint;

  Task(
      {required this.title,
      required this.description,
      required this.endDate,
      required this.isRecurring,
      required this.recurrenceInterval,
      required this.rewardPoint,
      required this.startDate,
      required this.taskGetter});

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
