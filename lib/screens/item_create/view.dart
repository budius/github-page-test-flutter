import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:elapsed_time/screens/item_create/view_model.dart';

ItemCreateViewModel _vm(BuildContext context) {
  return Provider.of(context, listen: false);
}

class ItemCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemCreateViewModel viewModel = _vm(context);
    return Container(
      constraints: BoxConstraints(maxWidth: 80),
      padding: EdgeInsets.all(24),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: viewModel.nameController,
              maxLength: 40,
              maxLines: 1,
              decoration: const InputDecoration(
                  icon: Icon(Icons.surround_sound),
                  hintText: "Short name, max 40 chars",
                  labelText: "Name"),
            ),
            TextFormField(
              controller: viewModel.descriptionController,
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
                          stream: viewModel.date,
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
                          stream: viewModel.time,
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
                await viewModel.add();
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
  ItemCreateViewModel viewModel = _vm(context);
  DateTime selection = await showDatePicker(
      context: context,
      initialDate: viewModel.initialDate,
      firstDate: viewModel.earliestDate,
      lastDate: viewModel.latestDate,
      initialDatePickerMode: DatePickerMode.day);
  viewModel.dateSelected(selection);
}

void _showTimePicker(BuildContext context) async {
  removeFocus(context);
  ItemCreateViewModel viewModel = _vm(context);
  TimeOfDay selection =
      await showTimePicker(context: context, initialTime: viewModel.initialTime);
  viewModel.timeSelected(selection);
}

void removeFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}
