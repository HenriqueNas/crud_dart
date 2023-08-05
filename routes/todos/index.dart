import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../src/crud_dart.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final result = switch (context.request.method) {
    HttpMethod.get => _get(context),
    HttpMethod.post => await _post(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };

  return result;
}

Response _get(RequestContext context) {
  final store = context.read<TodosStore>();

  return Response.json(
    body: {
      'todos': store.todos,
    },
  );
}

Future<Response> _post(RequestContext context) async {
  var body = await context.request.json();

  if (body is! Map<String, dynamic>) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Invalid body',
    );
  }

  body = body.cast<String, dynamic>();

  final todo = CreateNewTodoParams(
    title: body['title'] as String,
    description: body['description'] as String?,
  ).toTodo();

  context.read<TodosStore>().add(todo);

  return Response.json(
    body: todo,
    statusCode: HttpStatus.created,
  );
}
