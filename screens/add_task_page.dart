import 'package:flutter/material.dart';
import '../models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  final Task? task;
  final bool isEditing;

  AddTaskPage({this.task, this.isEditing = false});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedTime;
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedTime = widget.task!.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Editar Tarefa' : 'Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associamos o formulário a uma GlobalKey
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                // Validação do título
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                // Validação da descrição
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha a descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime != null
                        ? TimeOfDay.fromDateTime(_selectedTime!)
                        : TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _selectedTime = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  }
                },
                child: Text(
                  _selectedTime == null
                      ? 'Selecionar Horário'
                      : 'Horário Selecionado: ${_selectedTime!.hour}:${_selectedTime!.minute}',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Se os campos forem válidos, cria ou edita a tarefa
                    final task = Task(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      time: _selectedTime ?? DateTime.now(),
                    );
                    Navigator.pop(context, task);
                  } else {
                    // Mostra a mensagem de erro se os campos forem inválidos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Preencha os campos obrigatórios')),
                    );
                  }
                },
                child: Text(
                    widget.isEditing ? 'Editar Tarefa' : 'Adicionar Tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
