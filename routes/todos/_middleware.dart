import 'package:dart_frog/dart_frog.dart';

import '../../src/stores/todos_stores.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<TodosStore>((_) => _store),
  );
}

final _store = TodosStore();
