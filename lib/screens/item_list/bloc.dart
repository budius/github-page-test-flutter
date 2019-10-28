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

  @override
  void onDispose() {
    _items.close();
    super.onDispose();
  }
}
