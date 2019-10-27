import 'dart:async';

import 'package:elapsed_time/model/item.dart';
import 'package:elapsed_time/model_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

import 'item_model.dart';

class ItemBloc extends ViewModel {
  ItemModel model;

  final BehaviorSubject<String> _textController = BehaviorSubject<String>();
  Timer _timer;

  Stream<String> get text => _textController.stream;

  ItemBloc(Item _item) {
    model = ItemModel(_item);
    _textController.add(model.getText());
    _timer = Timer.periodic(Duration(milliseconds: 64), (Timer timer) {
      _textController.add(model.getText());
    });
  }

  @override
  void onDispose() {
    debugPrint("Disposing of the ItemBloc");
    _textController.sink.close();
    _timer.cancel();
    super.onDispose();
  }
}
