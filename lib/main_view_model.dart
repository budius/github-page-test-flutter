import 'package:elapsed_time/main_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';


class MViewModel extends Model {

}

class MainViewModel extends State<MainView> {
  final List<int> _items = [];
  final String _title;

  MainViewModel(this._title) {
    new Timer.periodic(new Duration(milliseconds: 60), timerUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return MainView.build(_title, _items, addItem);
  }

  void addItem() {
    setState(() {
      _items.add(new DateTime.now().millisecondsSinceEpoch);
    });
  }

  void timerUpdate(Timer timer) {
    setState(() {});
  }
}
