class EndPoint {

  //initial private
  EndPoint._privateConstructor();
  static final EndPoint instance = EndPoint._privateConstructor();

  String endPoint_GetTodo ({page = 0}) {
    return 'https://jsonplaceholder.typicode.com/todos?_start= ${1+(page*10)}&_limit=10';
  }

  String endPoint_GetUser() {
    return 'https://jsonplaceholder.typicode.com/users';
  }

  String endPoint_GetTodoByUserID(int userId) {
    return 'https://jsonplaceholder.typicode.com/users/$userId/todos';
  }
}