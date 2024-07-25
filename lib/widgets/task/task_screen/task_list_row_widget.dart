import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/alert_dialog_task_info_widget.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListRowWidget extends StatelessWidget {
  final TaskResponse task;
  final TaskModel taskModel;
  final bool isGetterWidget;

  const TaskListRowWidget({
    super.key,
    required this.task,
    required this.taskModel,
    required this.isGetterWidget,
  });

// Text(
//                   '${value[index].title}\n${modelTask.returnGetterString(
//                     value[index].taskGetter,
//                     userModel.id,
//                     familyModel,
//                     value[index].isCompleted,
//                   )}'
  @override
  Widget build(BuildContext context) {
    final familyModel = context.read<FamilyModel>();
    final userModel = context.read<UserModel>();
    final _apiClient = ApiClient();
    return ListTile(
      trailing: (task.isCompleted)
          ? const Icon(Icons.done)
          : const Icon(Icons.access_time),
      title: Text(task.title),
      subtitle: Text(
        taskModel.returnGetterString(
          task.taskGetter,
          userModel.id,
          familyModel,
          task.isCompleted,
        ),
      ),
      onTap: () {
        alertDialogTaskInfoWidget(
          context,
          familyModel,
          _apiClient,
          task,
          isGetterWidget,
          taskModel,
        );
      },
    );
  }
}
