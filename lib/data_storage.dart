import 'dart:async';
import 'dart:collection';
import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  // should I still keep the local backing of pre-parsed data?
  // it would takes longer to call `allItems` but using less memory.
  // one day I'll profile that
  final Map<String, ElapsedItem> _data = HashMap();
  Completer<void> _loadCompleted = Completer<void>();
  SharedPreferences _prefs;

  DataStorage() {
    _loadData();
  }

  void _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    for (String key in _prefs.getKeys()) {
      _data[key] = ElapsedItem.fromJsonString(_prefs.getString(key));
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

  Future<ElapsedItem> getItem(String id) async {
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
}
