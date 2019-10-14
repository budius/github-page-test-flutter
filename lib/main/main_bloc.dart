import 'dart:async';

import 'package:elapsed_time/model/item.dart';
import 'package:rxdart/subjects.dart';

class MainData {
  String title = "Hello Block";
  final List<Item> items = initialItems(now);
}

class MainBloc {
  MainData data = MainData();

  Stream<String> get title => _titleController.stream;

  Stream<List<Item>> get items => _itemsController.stream;

  final BehaviorSubject<List<Item>> _itemsController =
      BehaviorSubject<List<Item>>();

  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();

  MainBloc() {
    _titleController.add(data.title);
    _itemsController.add(data.items);
  }

  void addItem() {
    int next = data.items.length;
    data.items.add(Item(next, "I am $next", now));
    _itemsController.add(data.items);
  }
}

final int now = DateTime.now().millisecondsSinceEpoch;

List<Item> initialItems(int now) => [
      Item(0, "I am zero", now),
      Item(1, "I am one", now + 1),
      Item(2, "I am two", now + 2),
      Item(3, "I am three", now + 3),
      Item(4, "I am four", now + 4),
      Item(5, "I am five", now + 5),
      Item(6, "I am six", now + 6)
    ];
