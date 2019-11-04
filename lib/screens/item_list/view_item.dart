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
      child: ListTile(
        title: Text(_item.shortName),
        subtitle: TimerText(_item),
        isThreeLine: true,
        onTap: () => {},
      ),
    );
  }
}

class TimerText extends StatefulWidget {
  final ElapsedItem _item;

  const TimerText(this._item, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TimerTextState(_item);
  }
}

class TimerTextState extends State<TimerText> {
  final ElapsedItem _item;
  Timer _timer;
  String _text = "";

  TimerTextState(this._item);

  @override
  Widget build(BuildContext context) {
    return Text(_text);
  }

  @override
  void initState() {
    _updateText();
    _timer = Timer.periodic(
        Duration(milliseconds: 64), (Timer timer) => {_updateText()});
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _text = "${_item.description} \n${ItemListBloc.mainCounterText(_item)}";
    });
  }
}
