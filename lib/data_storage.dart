import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  // should I still keep the local backing of pre-parsed data?
  // it would takes longer to call `allItems` but using less memory.
  // one day I'll profile that
  final Map<String?, ElapsedItem> _data = HashMap();
  Completer<void> _loadCompleted = Completer<void>();
  late SharedPreferences _prefs;

  DataStorage() {
    // _testLoadRandomItems();
    _loadData();
  }

  void _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    for (String key in _prefs.getKeys()) {
      _data[key] = ElapsedItem.fromJsonString(_prefs.getString(key)!);
    }
    _loadCompleted.complete();
  }

  Future<ElapsedItem> addItem(
      String shortName, String description, DateTime instant) async {
    await _loadCompleted.future;
    String id = Uuid().v4();
    ElapsedItem newItem =
        ElapsedItem(id, shortName, description, instant, DateTime.now());
    _data[id] = newItem;
    await _prefs.setString(id, newItem.toJsonString());
    return newItem;
  }

  Future<ElapsedItem?> getItem(String id) async {
    await _loadCompleted.future;
    return _data[id];
  }

  Future<void> deleteItem(String id) async {
    await _loadCompleted.future;
    await _prefs.remove(id);
    _data.remove(id);
  }

  Future<List<ElapsedItem>> get allItems async {
    await _loadCompleted.future;
    List<ElapsedItem> list = _data.values.toList(growable: false);
    list.sort((a, b) => a.instant.compareTo(b.instant));
    return list;
  }

  void _testLoadRandomItems() {
    Random r = Random();
    const String chars = "qazwsxedcrfvtgbyhnujmikolp1234567890 ";
    String randomString(int length) {
      StringBuffer sb = StringBuffer();
      for (int i = 0; i < length; i++) {
        sb.write(chars[r.nextInt(chars.length)]);
      }
      return sb.toString();
    }

    for (int i = 0; i < 100; i++) {
      ElapsedItem item = ElapsedItem(
          Uuid().v4(),
          randomString(10),
          randomString(100),
          DateTime.now().add(Duration(days: r.nextInt(365 * 2) - 365)),
          DateTime.now());
      _data[item.id] = item;
    }
  }
}
