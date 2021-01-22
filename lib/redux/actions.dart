import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/model/user.dart';

class AddTodoAction {
  static int _id = 0;
  final Todo todo;

  AddTodoAction(this.todo) {
    _id++;
  }
  int get id => _id;
}

class RemoveTodoAction {
  final Todo todo;
  RemoveTodoAction(this.todo);
}

// ignore: must_be_immutable
class FetchTodosAction {
  int page = 0;

  final List<Todo> todos;
  FetchTodosAction(this.todos);
}

class FetchUsersAction {
  final List<User> users;
  FetchUsersAction(this.users);
}

class RemoveTodosAction {}

class ErrorExceptionAction {}
class SocketExceptionAction {}
class TimeoutExceptionAction {}

class LoadingDataAction {}
