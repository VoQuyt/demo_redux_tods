import 'package:demo_redux_tods/model/user.dart';
import 'package:flutter/foundation.dart';

//https://jsonplaceholder.typicode.com/todos?_start=1&_limit=10

class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Todo({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Todo copyWith({int id, int userId, String title, bool compeleted}) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      completed: compeleted ?? this.completed,
    );
  }
}

enum STATUS_STATE {
  STATE_SUCCESS,
  STATE_LOADING,
  STATE_EMPTY,
  STATE_ERROR,
  STATE_SOCKET_FAIL,
  STATE_TIMEOUT
}

class StoreApp {
  final List<Todo> todos;
  final List<User> users;
  final STATUS_STATE status;

  StoreApp({
    @required this.todos,
    @required this.users,
    @required this.status,
  });

  StoreApp.initialState()
      : todos = List.unmodifiable(<Todo>[]),
        users = List.unmodifiable(<User>[]),
        status = STATUS_STATE.STATE_EMPTY;
}
