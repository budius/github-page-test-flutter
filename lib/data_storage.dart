import 'dart:collection';

import 'package:elapsed_time/model/elapsed_item.dart';

/// Not a real storage, just hold onto the values
/// Maybe in the future I add a real storage from here
class DataStorage {
  final Map<String, ElapsedItem> _data = HashMap();

  void addItem(ElapsedItem item) {
    _data[item.id] = item;
  }

  ElapsedItem getItem(String id) {
    return _data[id];
  }

  List<ElapsedItem> get allItems {
    List<ElapsedItem> list = _data.values.toList(growable: false);
    list.sort((a, b) => a.instant.compareTo(b.instant));
    return list;
  }
}
