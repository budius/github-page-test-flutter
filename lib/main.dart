import 'package:flutter/material.dart';
import 'routes_definition.dart';
import 'service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routesDefinition,
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'RobotoRegular'),
    );
  }
}
