import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:rxdart/rxdart.dart';

import 'package:elapsed_time/data_storage.dart';
import 'package:elapsed_time/model_provider.dart';
import 'package:elapsed_time/service_locator.dart';

class ItemListBloc extends ViewModel {
  final DataStorage dataStorage = locator.get();

  final BehaviorSubject<List<ElapsedItem>> _items =
      BehaviorSubject<List<ElapsedItem>>();

  Stream<List<ElapsedItem>> get items => _items.stream;

  ItemListBloc() {
    _items.add(dataStorage.allItems);
  }

  void update() {
    _items.add(dataStorage.allItems);
  }

  static String mainCounterText(ElapsedItem item) {
    return "${item.instant.difference(DateTime.now()).inMilliseconds}";
  }

  static String elapsedToYears(ElapsedItem item) {
    Duration diff = DateTime.now().difference(item.instant);
    if (diff.inDays.abs() > 365) {
      int years = diff.inDays ~/ 365;
      int days = diff.inDays - (years * 365);
      return "$years years and ${leadingZeros(days, 2)} days";
    } else {
      return null;
    }
  }

  static String elapsedToDays(ElapsedItem item) {
    Duration diff = DateTime.now().difference(item.instant);
    if (diff.inDays.abs() > 0) {
      int days = diff.inDays;
      int hours = diff.inHours - (days * 24);
      int minutes = diff.inMinutes - (days * 24 * 60) - (hours * 60);
      return "${leadingZeros(days, 2)} days, ${leadingZeros(hours, 2)} hours and ${leadingZeros(minutes, 2)} minutes";
    } else {
      return null;
    }
  }

  static String elapsedToHours(ElapsedItem item) {
    Duration diff = DateTime.now().difference(item.instant);
    int hours = diff.inHours;
    int minutes = diff.inMinutes - (hours * 60);
    int seconds = diff.inSeconds - (hours * 60 * 60) - (minutes * 60);
    int ms = diff.inMilliseconds -
        (hours * 60 * 60 * 1000) -
        (minutes * 60 * 1000) -
        (seconds * 1000);
    return "${leadingZeros(hours, 2)} hours, ${leadingZeros(minutes, 2)} minutes, ${leadingZeros(seconds, 2)} seconds, ${leadingZeros(ms, 3)} ms";
  }

  static String leadingZeros(int value, int size) {
    return value.toString().padLeft(size, '0');
  }

  @override
  void onDispose() {
    _items.close();
    super.onDispose();
  }
}
