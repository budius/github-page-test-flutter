import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'package:elapsed_time/model/item.dart';
import 'package:elapsed_time/model_provider.dart';
import 'main_model.dart';

class MainBloc extends ViewModel {
  final MainModel model = MainModel();

  Stream<String> get title => _titleController.stream;

  Stream<List<Item>> get items => _itemsController.stream;

  final BehaviorSubject<List<Item>> _itemsController =
      BehaviorSubject<List<Item>>();

  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();

  MainBloc() {
    debugPrint("Starting of the MainBlock");
    _titleController.add(model.title);
    _itemsController.add(model.items);
  }

  void addItem() {
    model.addItem();
    _itemsController.add(model.items);
  }

  @override
  void onDispose() {
    debugPrint("Disposing of the MainBlock");
    _titleController.sink.close();
    _itemsController.sink.close();
  }
}
