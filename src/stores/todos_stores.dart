import '../models/todo.dart';

class TodosStore {
  final List<Todo> _todos = [
    Todo.now(
      id: '1',
      title: 'Todo title',
      description: 'Todo description',
      completed: true,
    ),
  ];

  List<Todo> get todos => _todos;

  void add(Todo todo) {
    _todos.add(todo);
  }

  void remove(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}
