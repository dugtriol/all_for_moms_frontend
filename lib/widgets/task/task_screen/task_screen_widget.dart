import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_form/task_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    final taskModel = context.read<TaskModel>();
    final familyModel = context.read<FamilyModel>();
    if (familyModel.familyIsExist) {
      taskModel.updateTasks(userId: userModel.id);
    }

    return familyModel.familyIsExist
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
    return Scaffold(
      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _TaskListRowWidget(
              task: taskModel.tasks![index],
              indexInList: index,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
          itemCount: taskModel.tasks?.length ?? 0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        child: const Icon(Icons.add),
        onPressed: () {
          //Navigator.pushNamed(context, MainNavigationRoutes.taskForm);
          Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => TaskFormWidget()));
        },
      ),
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  final TaskResponse task;

  const _TaskListRowWidget({
    super.key,
    required this.indexInList,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    // var lists = context.read<ListOfTasks>();
    // final task = lists.getlistOfTasks[indexInList];
    // final title = arrayOfTasks[indexInList].title;
    // final description = arrayOfTasks[indexInList].description;
    return ListTile(
      title: Text("${task.title}"),
      subtitle: Text("${task.description}"),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("${task.title}"),
                scrollable: true,
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('id: ${task.id}\n'),
                      Text('Описание: ${task.description}\n'),
                      Text('id выполняет: ${task.taskGetter}'),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Exit"))
                ],
              );
            });
      },
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
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Нет заданий'),
          ],
        ),
      ),
    );
  }
}
