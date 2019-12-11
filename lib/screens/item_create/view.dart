import 'package:elapsed_time/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:elapsed_time/screens/item_create/bloc.dart';

ItemCreateBloc _bloc(BuildContext context) {
  return ModelProvider.getModel(context);
}

class ItemCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemCreateBloc bloc = _bloc(context);
    return Container(
      constraints: BoxConstraints(maxWidth: 80),
      padding: EdgeInsets.all(24),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: bloc.nameController,
              maxLength: 40,
              maxLines: 1,
              decoration: const InputDecoration(
                  icon: Icon(Icons.surround_sound),
                  hintText: "Short name, max 40 chars",
                  labelText: "Name"),
            ),
            TextFormField(
              controller: bloc.descriptionController,
              maxLength: 280,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                  icon: Icon(Icons.camera_alt),
                  hintText:
                      "(Optional)\nWhy is that point in time relevant, max 2 tweets",
                  labelText: "Description"),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: RaisedButton(
                      child: StreamBuilder<String>(
                          stream: bloc.date,
                          builder: (context, snapshot) {
                            return Text(
                                snapshot.data == null ? "" : snapshot.data);
                          }),
                      onPressed: () => _showDatePicker(context),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: RaisedButton(
                      child: StreamBuilder<String>(
                          stream: bloc.time,
                          builder: (context, snapshot) {
                            return Text(
                                snapshot.data == null ? "" : snapshot.data);
                          }),
                      onPressed: () => _showTimePicker(context),
                    ),
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text("Add"),
              onPressed: () async {
                await bloc.add();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showDatePicker(BuildContext context) async {
  removeFocus(context);
  ItemCreateBloc bloc = _bloc(context);
  DateTime selection = await showDatePicker(
      context: context,
      initialDate: bloc.initialDate,
      firstDate: bloc.earliestDate,
      lastDate: bloc.latestDate,
      initialDatePickerMode: DatePickerMode.day);
  bloc.dateSelected(selection);
}

void _showTimePicker(BuildContext context) async {
  removeFocus(context);
  ItemCreateBloc bloc = _bloc(context);
  TimeOfDay selection =
      await showTimePicker(context: context, initialTime: bloc.initialTime);
  bloc.timeSelected(selection);
}

void removeFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}
