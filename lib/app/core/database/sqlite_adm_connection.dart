
import 'package:cuidapet/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/material.dart';

class SqliteAdmConnection with WidgetsBindingObserver{
  var connection = SqliteConnectionFactory();


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
    case AppLifecycleState.resumed:
      break;
    case AppLifecycleState.inactive:
    case AppLifecycleState.paused:
    case AppLifecycleState.detached:
      connection.closeConnection();   
  }

    super.didChangeAppLifecycleState(state);
  }

}