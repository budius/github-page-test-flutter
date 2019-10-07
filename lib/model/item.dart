class Item {
  int _id;
  String _name;
  int _timestamp;

  Item(this._id, this._name, this._timestamp);

  int get id => _id;

  String get name => _name;

  int get timestamp => _timestamp;
}
