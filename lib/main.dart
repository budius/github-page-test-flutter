import 'package:flutter/material.dart';
import 'package:elapsed_time/routes_definition.dart';
import 'package:elapsed_time/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: routesDefinition,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
          fontFamily: 'RobotoRegular'),
    );
  }
}
