import 'package:uuid/uuid.dart';

import 'todo.dart';

class CreateNewTodoParams {
  CreateNewTodoParams({
    required this.title,
    this.description,
  });

  final String title;
  final String? description;

  Todo toTodo() {
    return Todo.now(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
  }
}
