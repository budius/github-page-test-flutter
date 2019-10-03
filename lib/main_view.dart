import 'package:elapsed_time/main_view_model.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  MainView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MainViewModel createState() => MainViewModel(title);

  static Widget build(String title, List<int> items, VoidCallback onFabPressed) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(8.0),
        itemExtent: 20.0,
        itemBuilder: (BuildContext context, int index) {
          int start = items[index];
          int end = new DateTime.now().millisecondsSinceEpoch;
          int diff = end - start;
          return Text('entry $index -> $diff');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
