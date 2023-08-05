/// A [Todo] entity.
class Todo {
  /// Creates a [Todo].
  const Todo({
    required this.id,
    required this.title,
    required this.createdAt,
    this.description,
    this.completed = false,
  });

  /// Creates a [Todo] with the current date and time.
  factory Todo.now({
    required String id,
    required String title,
    String? description,
    bool completed = false,
  }) {
    return Todo(
      id: id,
      title: title,
      description: description,
      completed: completed,
      createdAt: DateTime.now(),
    );
  }

  /// Creates a [Todo] from a JSON object.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      completed: json['completed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  factory Todo.fromDynamic(dynamic object) {
    if (object is Todo) {
      return object;
    } else if (object is Map<String, dynamic>) {
      return Todo.fromJson(object);
    } else if (object is Map<String, Object>) {
      return Todo.fromJson(object);
    } else if (object is Map) {
      return Todo.fromJson(object.cast<String, dynamic>());
    }

    throw FormatException(
      'Could not parse a Todo from ${object.runtimeType}',
    );
  }

  /// The unique identifier of the [Todo].
  final String id;

  /// A title of the [Todo].
  final String title;

  /// A description of the [Todo].
  final String? description;

  /// A flag indicating whether the [Todo] is completed.
  final bool completed;

  /// The date and time when the [Todo] was created.
  final DateTime createdAt;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      if (description != null) 'description': description!,
      'completed': completed,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
