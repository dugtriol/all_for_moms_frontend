import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_list_row_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class TaskListGetterWidget extends StatelessWidget {
  final UserModel userModel;
  final TaskModel taskModel;
  final FamilyModel familyModel;
  const TaskListGetterWidget({
    super.key,
    required this.familyModel,
    required this.taskModel,
    required this.userModel,
  });
  @override
  Widget build(BuildContext context) {
    if (familyModel.familyIsExist) {
      taskModel.updateTasksGetter(userId: userModel.id);
    }

    return (familyModel.familyIsExist)
        ? IfTasksGetterExistWidget(taskModel: taskModel)
        : IfTasksGetterNotExist(
            taskModel: taskModel,
          );
  }
}

class IfTasksGetterExistWidget extends StatelessWidget {
  const IfTasksGetterExistWidget({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GroupedListView(
        elements: taskModel.tasksGetter!,
        groupBy: (element) => element.endDate.toString(),
        groupComparator: (a, b) => a.compareTo(b),
        useStickyGroupSeparators: true,
        itemBuilder: (c, element) {
          return Card(
            child: TaskListRowWidget(
              task: element,
              taskModel: taskModel,
              isGetterWidget: false,
            ),
          );
        },
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        groupHeaderBuilder: (element) {
          return SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                taskModel.returnDateString(element.endDate!),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class IfTasksGetterNotExist extends StatelessWidget {
  const IfTasksGetterNotExist({
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
