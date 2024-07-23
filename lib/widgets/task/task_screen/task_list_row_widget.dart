import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/alert_dialog_task_info_widget.dart';
import 'package:all_for_moms_frontend/utils/build_text_field_widget.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  final TaskResponse task;
  final TaskModel taskModel;
  final bool isGetterWidget;

  const TaskListRowWidget({
    super.key,
    required this.indexInList,
    required this.task,
    required this.taskModel,
    required this.isGetterWidget,
  });

  @override
  Widget build(BuildContext context) {
    final familyModel = context.read<FamilyModel>();
    final _apiClient = ApiClient();
    return ListTile(
      trailing: (task.isCompleted) ? Icon(Icons.done) : Icon(Icons.access_time),
      title: Text("${task.title}"),
      subtitle: Text("${taskModel.getDeadline(task.endDate)}"),
      onTap: () {
        alertDialogTaskInfoWidget(
          context,
          familyModel,
          _apiClient,
          task,
          indexInList,
          isGetterWidget,
          taskModel,
        );
      },
    );
  }
}
