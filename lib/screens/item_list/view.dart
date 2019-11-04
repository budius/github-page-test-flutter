import 'package:elapsed_time/routes_definition.dart';
import 'package:elapsed_time/screens/item_list/view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:elapsed_time/model_provider.dart';
import 'package:elapsed_time/model/elapsed_item.dart';

import 'package:elapsed_time/screens/item_list/bloc.dart';

ItemListBloc _bloc(BuildContext context) {
  return ModelProvider.getModel<ItemListBloc>(context);
}

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: buildFab(context),
      body: buildListFromBloc(context),
    );
  }
}

Widget buildAppBar(BuildContext context) => AppBar(
      title: Text("Hello Elapsed Time"),
    );

Widget buildFab(BuildContext context) {
  return FloatingActionButton(
      onPressed: () async {
        await showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            builder: routesDefinition[Routes.create]);
        _bloc(context).update();
      },
      tooltip: 'Add new item',
      child: Icon(Icons.add));
}

Widget buildListFromBloc(BuildContext context) {
  ItemListBloc bloc = _bloc(context);
  return StreamBuilder<List<ElapsedItem>>(
    stream: bloc.items,
    builder: (context, snapshot) {
      int count = snapshot.data != null ? snapshot.data.length : 0;
      if (count == 0) {
        return buildEmptyView(context);
      } else {
        return buildListFromItems(context, snapshot.data);
      }
    },
  );
}

Widget buildEmptyView(BuildContext context) {
  return Center(
    child: Text("Nothing to see here"),
  );
}

Widget buildListFromItems(BuildContext context, List<ElapsedItem> items) {
  return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500, childAspectRatio: goldenRatio),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => CardItem(items[index]));
}

double goldenRatio = 1.61803398875;
