import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/model/user.dart';
import 'package:demo_redux_tods/redux/actions.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class API {
  //Singleton
  API._privateConstructor();
  static final API instance = API._privateConstructor();

  /*
    hàm fetchTodoFromApi và hàm fetchUserFromApi (line 43) có thể viết gộp chung thành 1 hàm
    có thể fetch được tất cả các loại data (nhưng chưa làm)
  */
  Future<void> fetchTodoFromApi(Store<StoreApp> store,
      String endpoint) async {
  
  /** 
   * khi fetch data thì trong quá trình chờ dử liệu, mình sẽ dispath 1 action loadingDataAction (vd: line 32)
   * để cho giao diện xử lý màn hình chờ dử liệu
   * 
   * nếu dử liệu lấy xuống lổi hay bắt được Exception thì dispath ExceptionAction tương ứng để xử lý(vd: line 44, 48, 51, 53)
   * 
   *
   * nếu dử liệu lấy xuống thành công thì mình dispath Action load dử liệu lên giao diện (vd: line 41)
   * 
   **/
    store.dispatch(LoadingDataAction());

    try {
      final response = await http.get(endpoint).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        List<Todo> _temp = [];
        for (final data in jsonDecode(response.body) as List) {
          _temp.add(Todo.fromJson(data));
        }
        store.dispatch(FetchTodosAction(_temp));
      } else {
        print('Error get data fail!');
        store.dispatch(ErrorExceptionAction());
      }
    } on SocketException {
      print('Error no connect internet!');
      store.dispatch(SocketExceptionAction());
    } on TimeoutException catch (e) {
      print('Error timeout: $e');
      store.dispatch(TimeoutExceptionAction());
    } on Error catch (e) {
      print('Error: $e');
      store.dispatch(ErrorExceptionAction());
    }
  }

  Future<void> fetchUserFromApi(Store<StoreApp> store,
      String endpoint) async {
    store.dispatch(LoadingDataAction());
    try {
      final response =await http.get(endpoint).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        List<User> _temp = [];
        for (final data in jsonDecode(response.body) as List) {
          _temp.add(User.fromJson(data));
        }
        store.dispatch(FetchUsersAction(_temp));
      } else {
        print('Error get data fail!');
        store.dispatch(ErrorExceptionAction());
      }
    } on SocketException {
      print('Error no connect internet!');
      store.dispatch(SocketExceptionAction());
    } on TimeoutException catch (e) {
      print('Error timeout: $e');
      store.dispatch(TimeoutExceptionAction());
    } on Error catch (e) {
      print('Error: $e');
      store.dispatch(ErrorExceptionAction());
    }
  }
}
