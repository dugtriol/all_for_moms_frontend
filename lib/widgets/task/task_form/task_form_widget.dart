import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_form/task_create_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskFormWidget extends StatelessWidget {
  const TaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelCreateTask = context.watch<TaskCreateModel>();

    print('AddTaskWidget');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать задание'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: modelCreateTask.titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: 300,
              height: 100,
              child: TextField(
                controller: modelCreateTask.descriptionController,
                minLines: null,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  print(text);
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              height: 60,
              child: TextField(
                controller: modelCreateTask.endDateController,
                decoration: const InputDecoration(
                  labelText: 'Дата окончания',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.0,
                  ),
                ),
                onTap: () {
                  _selectEndDate(context);
                },
              ),
            ),
            const SizedBox(height: 32),
            recurrenceIntervalMenu(),
            const SizedBox(height: 32),
            getterNameMenu(),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {
                modelCreateTask.createTask();
                Navigator.of(context).pop();
                modelCreateTask.clearFields();
              },
              child: const Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectEndDate(BuildContext context) async {
    // final model = NotifierProvider.read<SignUpModel>(context);
    // final model = context.read<SignUpModel>();
    final model = context.read<TaskCreateModel>();
    DateTime? _picker = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_picker != null) {
      model?.endDateController.text = _picker.toString().split(" ")[0];
    }
  }
}

class recurrenceIntervalMenu extends StatelessWidget {
  recurrenceIntervalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TaskCreateModel>();
    final list = model.list;
    String dropdownValue = list.first;
    return DropdownMenu<String>(
      label: const Text("Повтор"),
      controller: model.reccuranceController,
      width: 300,
      initialSelection: list.first,
      onSelected: (String? value) {
        dropdownValue = value!;
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class getterNameMenu extends StatelessWidget {
  getterNameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final modelTaskCreate = context.read<TaskCreateModel>();
    final modelFamily = context.read<FamilyModel>();
    final list = modelFamily.listUsernameMembers;
    String dropdownValue = list?.first ?? "нет семьи";
    return list != null
        ? DropdownMenu<String>(
            label: const Text("Кому назначить"),
            controller: modelTaskCreate.membersController,
            width: 300,
            initialSelection: list.first,
            onSelected: (String? value) {
              dropdownValue = value!;
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        : const SizedBox.shrink();
  }
}
