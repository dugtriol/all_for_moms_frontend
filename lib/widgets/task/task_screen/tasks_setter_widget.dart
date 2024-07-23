import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_list_row_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_form/task_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListSetterWidget extends StatelessWidget {
  final UserModel userModel;
  final TaskModel taskModel;
  final FamilyModel familyModel;
  TaskListSetterWidget({
    super.key,
    required this.familyModel,
    required this.taskModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    if (familyModel.familyIsExist) {
      taskModel.updateTasksSetter(userId: userModel.id);
    }
// && taskModel.isListSetterNotEmpty()
    return (familyModel.familyIsExist)
        ? IfTasksExistWidget(taskModel: taskModel)
        : IfTasksNotExist(
            taskModel: taskModel,
          );
  }
}

class IfTasksExistWidget extends StatelessWidget {
  const IfTasksExistWidget({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return TaskListRowWidget(
            task: taskModel.tasksSetter![index],
            indexInList: index,
            taskModel: taskModel,
            isGetterWidget: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
        itemCount: taskModel.tasksSetter?.length ?? 0,
      ),
    );
  }
}

class IfTasksNotExist extends StatelessWidget {
  const IfTasksNotExist({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Нет заданий'),
        ],
      ),
    );
  }
}
