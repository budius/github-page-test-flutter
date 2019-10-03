import 'package:elapsed_time/main_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'RobotoRegular'
      ),
      home: MainView(title: 'Flutter Demo Home Page'),
    );
  }
}
