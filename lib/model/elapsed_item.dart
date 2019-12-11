import 'dart:convert';

class ElapsedItem {
  final String _id;
  final String _shortName;
  final String _description;
  final DateTime _instant;
  final DateTime _created;

  ElapsedItem(this._id, this._shortName, this._description, this._instant,
      this._created);

  DateTime get instant => _instant;

  DateTime get createdAt => _created;

  String get description => _description;

  String get shortName => _shortName;

  String get id => _id;

  String toJsonString() {
    return jsonEncode({
      '_id': this._id,
      '_shortName': this._shortName,
      '_description': this._description,
      '_instant': this._instant.millisecondsSinceEpoch,
      '_created': this._created.millisecondsSinceEpoch,
    });
  }

  factory ElapsedItem.fromJsonString(String jsonString) {
    Map<String, dynamic> map = jsonDecode(jsonString);
    return new ElapsedItem(
      map['_id'] as String,
      map['_shortName'] as String,
      map['_description'] as String,
      DateTime.fromMillisecondsSinceEpoch((map['_instant'] as int)),
      DateTime.fromMillisecondsSinceEpoch((map['_created'] as int)),
    );
  }
}
