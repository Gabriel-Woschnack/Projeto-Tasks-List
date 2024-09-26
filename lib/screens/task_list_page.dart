import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'add_task_page.dart';
import '../widgets/task_tile.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _editTask(Task oldTask, Task newTask) {
    setState(() {
      int index = tasks.indexOf(oldTask);
      tasks[index] = newTask;
    });
  }

  void _removeTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suas Tarefas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index],
                  onDelete: () => _removeTask(tasks[index]),
                  onEdit: (editedTask) => _editTask(tasks[index], editedTask),
                );
              },
            ),
          ),
          // Mover o botão "Adicionar Tarefa" mais para cima
          Padding(
            padding:
                const EdgeInsets.only(bottom: 75.0), // Espaçamento inferior
            child: Align(
              alignment:
                  Alignment.bottomCenter, // Centraliza o botão horizontalmente
              child: ElevatedButton(
                onPressed: () async {
                  final newTask = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTaskPage()),
                  );
                  if (newTask != null) {
                    _addTask(newTask);
                  }
                },
                child: Text('Adicionar Tarefa'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
