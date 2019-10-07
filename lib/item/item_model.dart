import 'package:elapsed_time/model/item.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemModel extends Model {
  Item _item;

  ItemModel(this._item);

  get text => "${_item.id} - ${_item.name}";
}
