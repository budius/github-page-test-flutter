import 'dart:async';

import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:elapsed_time/screens/item_list/bloc.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final ElapsedItem _item;

  const CardItem(this._item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AutoUpdateList(_item),
    );
  }
}

class AutoUpdateList extends StatefulWidget {
  final ElapsedItem _item;

  AutoUpdateList(this._item);

  @override
  State<StatefulWidget> createState() {
    return AutoUpdateListState(_item);
  }
}

class AutoUpdateListState extends State<AutoUpdateList> {
  final ElapsedItem _item;
  Timer _timer;
  List<String> _text;

  AutoUpdateListState(this._item);

  @override
  void initState() {
    _updateState();
    _timer = Timer.periodic(
        Duration(milliseconds: 64), (Timer timer) => {_updateState()});
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  void _updateState() {
    setState(() {
      List<String> text = List();
      text.add(_item.shortName);
      if (_item.description != null) {
        text.add(_item.description);
      }
      String years = ItemListBloc.elapsedToYears(_item);
      if (years != null) {
        text.add(years);
      }
      String days = ItemListBloc.elapsedToDays(_item);
      if (days != null) {
        text.add(days);
      }
      String hours = ItemListBloc.elapsedToHours(_item);
      if (hours != null) {
        text.add(hours);
      }
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = List();
    for (int i = 0; i < _text.length; i++) {
      columns.add(Text(_text[i]));
    }
    return Column(
      children: columns,
    );
  }
}
