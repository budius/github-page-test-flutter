import 'dart:async';

import 'package:elapsed_time/model/item.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model {
  static final int now = DateTime.now().millisecondsSinceEpoch;

  List<Item> _items = [
    Item(0, "I am zero", now),
    Item(1, "I am one", now + 1),
    Item(2, "I am two", now + 2),
    Item(3, "I am three", now + 3),
    Item(4, "I am four", now + 4),
    Item(5, "I am five", now + 5),
    Item(6, "I am six", now + 6)
  ];

  MainModel() {
    new Timer.periodic(
        new Duration(milliseconds: 60), (timer) => notifyListeners());
  }

  get title => "All items ($size)";

  get size => _items.length;

  String getText(int index) {
    Item item = _items[index];
    double time =
        (DateTime.now().millisecondsSinceEpoch - item.timestamp) / 1000.0;
    return "$index - ${item.name}. $time";
  }

  Item getItem(int index) => _items[index];

  void addItem() {
    _items.add(Item(_items.length, "I am ${_items.length}",
        DateTime.now().millisecondsSinceEpoch));
    notifyListeners();
  }
}
