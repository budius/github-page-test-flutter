import 'dart:async';

import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:elapsed_time/screens/item_list/bloc.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final ElapsedItem _item;
  final Function onTap;

  const CardItem(this._item, this.onTap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ObjectKey(_item.id),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  right: 0,
                  child: InkResponse(
                    onTap: onTap,
                    child: Icon(Icons.close),
                  )),
              AutoUpdateList(_item),
            ],
          ),
        ),
      ),
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = List();
    columns.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          _item.shortName,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
        ),
      ),
    );
    if (_item.description != null) {
      columns.add(Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          _item.description,
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
      ));
    }

    columns.add(Padding(padding: EdgeInsets.only(bottom: 6.0)));

    String years = ItemListBloc.elapsedToYears(_item);
    if (years != null) {
      columns.add(Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(years),
      ));
    }
    String days = ItemListBloc.elapsedToDays(_item);
    if (days != null) {
      columns.add(Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(days),
      ));
    }
    String hours = ItemListBloc.elapsedToHours(_item);
    if (hours != null) {
      columns.add(Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(hours),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columns,
    );
  }
}
