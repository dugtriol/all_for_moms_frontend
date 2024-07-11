import 'package:all_for_moms_frontend/models/Task.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('AddTaskWidget');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: titleController,
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
              height: 200,
              child: TextField(
                controller: descriptionController,
                minLines: null,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Описание',
                ),
                onChanged: (text) {
                  print(text);
                },
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }
}
