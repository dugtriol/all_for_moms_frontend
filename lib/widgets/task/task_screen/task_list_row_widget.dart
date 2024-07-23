import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
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
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Задание ${task.id}"),
                scrollable: true,
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      _buildTextField('Задание', task.title),
                      _buildTextField('Описание', task.description),
                      !isGetterWidget
                          ? _buildTextField('Выполняет',
                              familyModel.getNameById(task.taskGetter))
                          : _buildTextField('Задал',
                              familyModel.getNameById(task.taskSetter)),
                    ],
                  ),
                ),
                actions: [
                  (isGetterWidget || task.isCompleted)
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                          onPressed: () {
                            _apiClient.completeTask(taskId: task.id);

                            Navigator.of(context).pop();
                          },
                          child: const Text("Выполнено"),
                        ),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Выход"))
                ],
              );
            });
      },
    );
  }

  Widget _buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        readOnly: true,
        // obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
