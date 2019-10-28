class ElapsedItem {
  final String _id;
  final String _shortName;
  final String _description;
  final DateTime _instant;

  ElapsedItem(this._id, this._shortName, this._description, this._instant);

  DateTime get instant => _instant;

  String get description => _description;

  String get shortName => _shortName;

  String get id => _id;
}
