import 'package:demo_redux_tods/api/api.dart';
import 'package:demo_redux_tods/api/endpoint.dart';
import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  UserDetailScreen({@required this.userId});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<StoreApp>(context, listen: false);
    API.instance.fetchTodoFromApi(
        store, EndPoint.instance.endPoint_GetTodoByUserID(userId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux Todo With User $userId'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        tooltip: 'refresh todos',
        onPressed: () {
          API.instance.fetchTodoFromApi(
              store, EndPoint.instance.endPoint_GetTodoByUserID(userId));
        },
      ),
      body: StoreConnector<StoreApp, Store<StoreApp>>(
        converter: (store) => store,
        // onWillChange: (store, vm) {
        //   if (store.state.status == STATUS_STATE.STATE_SOCKET_FAIL) {
        //     showInSnackBar(context, 'No connect internet...');
        //   } else if (store.state.status == STATUS_STATE.STATE_TIMEOUT) {
        //     showInSnackBar(context, 'Request timeout...');
        //   } else if (store.state.status == STATUS_STATE.STATE_ERROR) {
        //     showInSnackBar(context, 'Fetch data unsuccess...');
        //   } else {
        //     print('Fetch data success...');
        //   }
        // },
        builder: (context, store) {
          print('rebuild item list');
          Widget child;
          if (store.state.status == STATUS_STATE.STATE_LOADING) {
            child = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    width: 30,
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ]);
          } else {
            if (store.state.todos.isNotEmpty) {
              child = ListView(
                  children: store.state.todos
                      .map((Todo todo) => ListTile(
                            subtitle: Text(todo.id.toString()),
                            title: Text(todo.title),
                            selected: todo.completed,
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => store.dispatch(RemoveTodoAction(
                                  todo)), //model.onRemoveItem(item),
                            ),
                          ))
                      .toList());
            } else {
              child = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        API.instance.fetchTodoFromApi(store,
                            EndPoint.instance.endPoint_GetTodoByUserID(userId));
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Result empty...'),
                    )
                  ]);
            }
          }
          return Center(child: child);
        },
      ),
    );
  }

  showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }
}
