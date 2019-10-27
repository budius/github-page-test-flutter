import 'package:elapsed_time/model/item.dart';

class ItemModel {
  final Item _item;

  ItemModel(this._item);

  String getText() {
    return "${_item.name} - ${now() - _item.timestamp}";
  }

  int now() => DateTime.now().millisecondsSinceEpoch;
}
