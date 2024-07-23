import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/build_text_field_widget.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:flutter/material.dart';

Future<dynamic> alertDialogTaskInfoWidget(
  BuildContext context,
  FamilyModel familyModel,
  ApiClient _apiClient,
  TaskResponse task,
  int indexInList,
  bool isGetterWidget,
  TaskModel taskModel,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Задание ${task.id}"),
          scrollable: true,
          content: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                buildTextField('Задание', task.title),
                buildTextField('Описание', task.description),
                !isGetterWidget
                    ? buildTextField(
                        'Выполняет', familyModel.getNameById(task.taskGetter))
                    : buildTextField(
                        'Задал', familyModel.getNameById(task.taskSetter)),
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
}
