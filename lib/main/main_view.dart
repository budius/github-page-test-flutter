import 'package:flutter/material.dart';

import '../model/item.dart';
import '../model_provider.dart';
import '../routes_definition.dart';
import 'main_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildList(context),
      floatingActionButton: buildFab(context),
    );
  }
}

Widget buildAppBar(BuildContext context) {
  MainBloc bloc = ModelProvider.getModel<MainBloc>(context);
  return AppBar(
      title: StreamBuilder<String>(
    stream: bloc.title,
    builder: (context, snapshot) => Text(
      snapshot.data == null ? "" : snapshot.data,
      style: TextStyle(fontFamily: 'RobotoBlack'),
    ),
  ));
}

Widget buildFab(BuildContext context) {
  MainBloc bloc = ModelProvider.getModel<MainBloc>(context);
  return FloatingActionButton(
      onPressed: () => bloc.addItem(),
      tooltip: 'Add new item',
      child: Icon(Icons.add));
}

Widget buildList(BuildContext context) {
  MainBloc bloc = ModelProvider.getModel<MainBloc>(context);
  return StreamBuilder<List<Item>>(
    stream: bloc.items,
    builder: (context, snapshot) {
      int count = 0;
      if (snapshot.data != null) {
        count = snapshot.data.length;
      }
      return ListView.builder(
          itemCount: count,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.itemDetails,
                    arguments: snapshot.data[index]),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    snapshot.data[index].name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ));
          });
    },
  );
}
