import 'package:elapsed_time/data_storage.dart';
import 'package:elapsed_time/model/elapsed_item.dart';
import 'package:elapsed_time/model_provider.dart';
import 'package:elapsed_time/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ItemCreateBloc extends ViewModel {
  DateTime get earliestDate => DateTime.fromMillisecondsSinceEpoch(0);

  DateTime get latestDate => DateTime.now().add(Duration(days: 36500));

  DateTime get initialDate => _currentSelection;

  TimeOfDay get initialTime => TimeOfDay.fromDateTime(_currentSelection);

  final BehaviorSubject<DateTime> _selected = BehaviorSubject<DateTime>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Stream<String> get date => _selected.stream.map((DateTime dateTime) =>
      "${dateTime.day}/${dateTime.month}/${dateTime.year}");

  Stream<String> get time => _selected.stream
      .map((DateTime dateTime) => "${dateTime.hour}:${dateTime.minute}");

  DateTime _currentSelection = DateTime.now();

  ItemCreateBloc() {
    _updateStreams();
  }

  void _updateStreams({DateTime date, TimeOfDay time}) {
    if (date == null) {
      date = _currentSelection;
    }
    if (time == null) {
      time = TimeOfDay.fromDateTime(_currentSelection);
    }
    _currentSelection =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    _selected.add(_currentSelection);
  }

  void dateSelected(DateTime date) {
    _updateStreams(date: date);
  }

  void timeSelected(TimeOfDay time) {
    _updateStreams(time: time);
  }

  void add() {
    ElapsedItem item = ElapsedItem(Uuid().v4(), nameController.text,
        descriptionController.text, _currentSelection);
    DataStorage storage = locator.get<DataStorage>();
    storage.addItem(item);
  }

  @override
  void onDispose() {
    nameController.dispose();
    descriptionController.dispose();
    _selected.close();
    super.onDispose();
  }
}
