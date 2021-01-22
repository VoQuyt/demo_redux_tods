import 'package:demo_redux_tods/api/api.dart';
import 'package:demo_redux_tods/api/endpoint.dart';
import 'package:demo_redux_tods/component/user_screen.dart';
import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/redux/reducers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<StoreApp> store = Store<StoreApp>(
      storeTodoReducer,
      initialState: StoreApp.initialState(),
    );
    return StoreProvider<StoreApp>(
      store: store,
      child: MaterialApp(
        title: 'Redux App',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<StoreApp>(context, listen: false);
    API.instance.fetchUserFromApi(store, EndPoint.instance.endPoint_GetUser());
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux User'),
      ),
      body: UserScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        tooltip: 'refresh users',
        onPressed: () {
          API.instance
              .fetchUserFromApi(store, EndPoint.instance.endPoint_GetUser());
        },
      ),
    );
  }
}
