import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/model/user.dart';
import 'package:demo_redux_tods/redux/actions.dart';

StoreApp storeTodoReducer(StoreApp storeApp, action) {
  List<Todo> todos;
  List<User> users;
  STATUS_STATE status = STATUS_STATE.STATE_LOADING;
  switch (action.runtimeType) {
    case AddTodoAction:
      todos = []
        ..addAll(storeApp.todos)
        ..add(Todo(
            id: action.id,
            title: action.todo.title,
            userId: action.todo.userId,
            completed: action.todo.completed));
      users = storeApp.users;
      status = STATUS_STATE.STATE_SUCCESS;
      break;
    case RemoveTodoAction:
      todos = List.unmodifiable(List.from(storeApp.todos)..remove(action.todo));
      users = storeApp.users;
      status = STATUS_STATE.STATE_SUCCESS;
      break;
    case RemoveTodosAction:
      todos = List.unmodifiable([]);
      users = storeApp.users;
      status = STATUS_STATE.STATE_SUCCESS;
      break;
    case FetchTodosAction:
      if ((action.todos as List).isNotEmpty) {
        //todos = []..addAll(storeApp.todos)..addAll(action.todos);
        todos = []..addAll(action.todos);
      } else {
        todos = storeApp.todos;
      }
      users = storeApp.users;
      status = STATUS_STATE.STATE_SUCCESS;
      break;
    case FetchUsersAction:
      if ((action.users as List).isNotEmpty) {
        users = []..addAll(action.users);
      } else {
        users = storeApp.users;
      }
      todos = storeApp.todos;
      status = STATUS_STATE.STATE_SUCCESS;
      break;
    case LoadingDataAction:
      todos = storeApp.todos;
      users = storeApp.users;
      status = STATUS_STATE.STATE_LOADING;
      break;
    case ErrorExceptionAction:
      todos = storeApp.todos;
      users = storeApp.users;
      status = STATUS_STATE.STATE_ERROR;
      break;
    case SocketExceptionAction:
      todos = storeApp.todos;
      users = storeApp.users;
      status = STATUS_STATE.STATE_SOCKET_FAIL;
      break;
    case TimeoutExceptionAction:
      todos = storeApp.todos;
      users = storeApp.users;
      status = STATUS_STATE.STATE_TIMEOUT;
      break;
    default:
      todos = storeApp.todos;
      users = storeApp.users;
  }
  return StoreApp(todos: todos, users: users, status: status);
}
