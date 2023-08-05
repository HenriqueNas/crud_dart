import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../../src/models/todo.dart';
import '../../../../routes/todos/index.dart' as route;

@GenerateNiceMocks([MockSpec<RequestContext>(), MockSpec<Request>()])
import 'todos.mocks.dart';

void main() {
  late RequestContext context;
  late Request request;

  setUpAll(() {
    context = MockRequestContext();
    request = MockRequest();

    when(context.request).thenReturn(request);
  });

  group('GET /todos', () {
    setUp(() {
      when(request.method).thenReturn(HttpMethod.get);
    });

    test(
      'when request /todos, should return a list of Todo with status code 200',
      () async {
        final response = await route.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));

        final body = await response.json() as Map<String, dynamic>;
        final todosList = body['todos'] as List;

        final todos = todosList.map(Todo.fromDynamic).toList();

        expect(
          todos,
          everyElement(isA<Todo>()),
        );
      },
    );
  });

  group('POST /todos', () {
    setUp(() {
      when(request.method).thenReturn(HttpMethod.post);
    });

    test(
      'when request /todos with a valid body, should return a Todo with status code 201',
      () async {
        final todo = Todo.now(
          id: '1',
          title: 'Todo',
          description: 'Todo description',
        );

        when(request.json()).thenAnswer((_) async => todo.toJson());

        final response = await route.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.created));

        final body = await response.json() as Map<String, dynamic>;

        expect(
          body,
          equals(todo.toJson()),
        );
      },
    );

    test(
      'when request /todos with an invalid body, should return a status code 400',
      () async {
        when(request.json()).thenAnswer((_) async => 'invalid body');

        final response = await route.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.badRequest));
      },
    );

    test(
      'when create a new Todo, should be in the todo list',
      () async {
        final todo = Todo.now(
          id: '1',
          title: 'Todo',
          description: 'Todo description',
        );

        when(request.json()).thenAnswer((_) async => todo.toJson());

        final response = await route.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.created));

        final body = await response.json() as Map<String, dynamic>;

        expect(
          body,
          equals(todo.toJson()),
        );

        final response2 = await route.onRequest(context);

        expect(response2.statusCode, equals(HttpStatus.ok));

        final body2 = await response2.json() as Map<String, dynamic>;
        final todosList = body2['todos'] as List;

        final todos = todosList.map(Todo.fromDynamic).toList();

        expect(
          todos,
          everyElement(isA<Todo>()),
        );

        expect(
          todos,
          contains(todo),
        );
      },
    );
  });
}
