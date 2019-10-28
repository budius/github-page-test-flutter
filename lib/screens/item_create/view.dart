import 'package:elapsed_time/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bloc.dart';

ItemCreateBloc _bloc(BuildContext context) {
  return ModelProvider.getModel(context);
}

class ItemCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemCreateBloc bloc = _bloc(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Name"),
          TextField(),
          Text("Description"),
          TextField(),
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
            onPressed: () {
              /* TODO */
            },
          ),
        ],
      ),
      // floatingActionButton: buildFab(context),
    );
  }
}

void _showDatePicker(BuildContext context) async {
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
  ItemCreateBloc bloc = _bloc(context);
  TimeOfDay selection =
      await showTimePicker(context: context, initialTime: bloc.initialTime);
  bloc.timeSelected(selection);
}

//Widget buildFab(BuildContext context) {
//  return FloatingActionButton(
//      onPressed: () {
//        /* TODO */
//      },
//      tooltip: 'Add',
//      child: Icon(Icons.add));
//}
