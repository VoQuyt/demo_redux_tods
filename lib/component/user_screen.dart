import 'package:demo_redux_tods/api/api.dart';
import 'package:demo_redux_tods/api/endpoint.dart';
import 'package:demo_redux_tods/component/user_detail_screen.dart';
import 'package:demo_redux_tods/model/todo.dart';
import 'package:demo_redux_tods/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreApp, Store<StoreApp>>(
      converter: (store) => store,
      onWillChange: (store, vm) {
        if (store.state.status == STATUS_STATE.STATE_SOCKET_FAIL) {
          showInSnackBar(context, 'No connect internet...');
        } else if (store.state.status == STATUS_STATE.STATE_TIMEOUT) {
          showInSnackBar(context, 'Request timeout...');
        } else if (store.state.status == STATUS_STATE.STATE_ERROR) {
          showInSnackBar(context, 'Fetch data unsuccess...');
        } else {
          print('Fetch data success...');
        }
      },
      builder: (context, store) {
        print('rebuild user list');
        Widget child;
        if (store.state.status == STATUS_STATE.STATE_LOADING) {
          child = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
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
          if (store.state.users.isNotEmpty) {
            child = ListView(
                children: store.state.users
                    .map((User user) => ListTile(
                          leading: Text(user.id.toString()),
                          subtitle: Text(
                            user.name,
                            style: TextStyle(fontSize: 15.0),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailScreen(userId: user.id),
                              ),
                            );
                          },
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
                      API.instance.fetchUserFromApi(store, EndPoint.instance.endPoint_GetUser());
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
    );
  }

  showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }
}
