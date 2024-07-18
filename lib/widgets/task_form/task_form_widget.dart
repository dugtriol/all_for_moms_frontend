import 'package:flutter/material.dart';

class TaskFormWidget extends StatelessWidget {
  const TaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
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
