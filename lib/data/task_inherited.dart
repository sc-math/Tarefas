import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task(
        name: 'Aprender Flutter',
        photo: 'assets/images/dash.png',
        difficulty: 3,
        level: 0),
    Task(
      name: 'Andar de Bike',
      photo: 'assets/images/bike.webp',
      difficulty: 2,
      level: 0,
    ),
    Task(
      name: 'Meditar',
      photo: 'assets/images/meditar.jpeg',
      difficulty: 5,
      level: 0,
    ),
    Task(
      name: 'Ler',
      photo: 'assets/images/livro.jpg',
      difficulty: 4,
      level: 0,
    ),
    Task(
        name: 'Jogar',
        photo: 'assets/images/jogar.jpg',
        difficulty: 1,
        level: 0),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name: name, photo: photo, difficulty: difficulty, level: 0));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
