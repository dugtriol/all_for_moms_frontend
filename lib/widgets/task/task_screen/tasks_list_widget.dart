import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_form/task_form_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/tasks_getter_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/tasks_setter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    final taskModel = context.read<TaskModel>();
    final familyModel = context.read<FamilyModel>();
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Задания'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Нужно выполнить',
              ),
              Tab(
                text: 'Созданные',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TaskListGetterWidget(
              familyModel: familyModel,
              taskModel: taskModel,
              userModel: userModel,
            ),
            TaskListSetterWidget(
              familyModel: familyModel,
              taskModel: taskModel,
              userModel: userModel,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn3",
          child: const Icon(Icons.add_task),
          onPressed: () {
            //Navigator.pushNamed(context, MainNavigationRoutes.taskForm);
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (context) => const TaskFormWidget()));
          },
        ),
      ),
    );
  }
}
