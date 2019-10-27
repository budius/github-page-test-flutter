import 'package:elapsed_time/model/item.dart';

class MainModel {
  String title = "Hello Block";
  final List<Item> items = initialItems(now());

  void addItem() {
    int next = items.length;
    items.add(Item(next, "I am $next", now()));
  }
}

int now() => DateTime.now().millisecondsSinceEpoch;

List<Item> initialItems(int now) => [
      Item(0, "I am zero", now),
      Item(1, "I am one", now + 1),
      Item(2, "I am two", now + 2),
      Item(3, "I am three", now + 3),
      Item(4, "I am four", now + 4),
      Item(5, "I am five", now + 5),
      Item(6, "I am six", now + 6)
    ];
