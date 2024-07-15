import 'package:all_for_moms_frontend/widgets/models/task.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_detailed_widget.dart';
import 'package:flutter/material.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _TaskListRowWidget(indexInList: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
        itemCount: 2);
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;

  const _TaskListRowWidget({
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    // var lists = context.read<ListOfTasks>();
    // final task = lists.getlistOfTasks[indexInList];
    // final title = arrayOfTasks[indexInList].title;
    // final description = arrayOfTasks[indexInList].description;
    return ListTile(
      title: Text("title"),
      subtitle: Text("description"),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("title"),
                scrollable: true,
                content: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('Описание: ${"description"}\n'),
                      Text('Вознаграждение: ${3}\n'),
                      Text('Кто выполняет: '),
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
