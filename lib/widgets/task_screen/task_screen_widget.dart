import 'package:all_for_moms_frontend/domain/entity/task.dart';
import 'package:all_for_moms_frontend/utils/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/models/task.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_form_widget.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_detailed_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    final taskModel = context.read<TaskModel>();
    taskModel.updateTasks(userId: userModel.id);
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
          itemCount: taskModel.tasks!.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
  final Task task;

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
                      Text('Описание: ${task.description}\n'),
                      Text('Вознаграждение: ${task.rewardPoint}\n'),
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
