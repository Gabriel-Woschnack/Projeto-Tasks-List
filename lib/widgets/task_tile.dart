import 'package:flutter/material.dart';
import 'package:task_list/screens/add_task_page.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final Function(Task) onEdit;

  TaskTile({required this.task, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          // Exibe apenas se o horário foi definido
          Text('Horário: ${task.time.hour}:${task.time.minute}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final editedTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskPage(
                    task: task, // Passa a tarefa existente para edição
                    isEditing: true, // Define que estamos editando
                  ),
                ),
              );
              if (editedTask != null) {
                onEdit(editedTask);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
