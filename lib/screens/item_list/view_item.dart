import 'dart:async';

import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:elapsed_time/screens/item_list/view_model.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final ElapsedItem _item;
  final Function onTap;

  const CardItem(this._item, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ObjectKey(_item.id),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 16,
                right: 16,
                child: InkResponse(
                  onTap: onTap as void Function()?,
                  child: Icon(Icons.close),
                )),
            AutoUpdateList(_item),
          ],
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
  Timer? _timer;

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
    _timer!.cancel();
    _timer = null;
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> w = List.empty(growable: true);

    double baseline = 40.0;

    // title
    w.add(Baseline(
        baseline: baseline,
        baselineType: TextBaseline.alphabetic,
        child: Text(_item.shortName!,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Color(0xf0ffffff),
            ))));

    // description
    if (_validString(_item.description)) {
      baseline += 24.0;
      w.add(Baseline(
          baseline: baseline,
          baselineType: TextBaseline.alphabetic,
          child: Text(_item.description!,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color(0xf0ffffff),
              ))));
    } else {
      baseline += 8.0;
    }

    String? years = ItemListViewModel.elapsedToYears(_item);
    if (years != null) {
      baseline += 16.0;
      w.add(Baseline(
          baseline: baseline,
          baselineType: TextBaseline.alphabetic,
          child: Text(years,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(0xc0ffffff),
              ))));
    }

    String? days = ItemListViewModel.elapsedToDays(_item);
    if (days != null) {
      baseline += 16.0;
      w.add(Baseline(
          baseline: baseline,
          baselineType: TextBaseline.alphabetic,
          child: Text(days,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(0xc0ffffff),
              ))));
    }

    String hours = ItemListViewModel.elapsedToHours(_item);
    if (hours != null) {
      baseline += 16.0;
      w.add(Baseline(
          baseline: baseline,
          baselineType: TextBaseline.alphabetic,
          child: Text(hours,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(0xc0ffffff),
              ))));
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(children: w));
  }
}

bool _validString(String? s) {
  return s != null && s.isNotEmpty;
}
