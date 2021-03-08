import 'package:elapsed_time/routes_definition.dart';
import 'package:elapsed_time/screens/item_list/view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:elapsed_time/model/elapsed_item.dart';

import 'package:elapsed_time/screens/item_list/view_model.dart';
import 'package:provider/provider.dart';

ItemListViewModel _vm(BuildContext context) {
  return Provider.of(context, listen: false);
}

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context) as PreferredSizeWidget?,
      floatingActionButton: buildFab(context),
      body: buildList(context),
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
            builder: routesDefinition[Routes.create]!);
        _vm(context).update();
      },
      tooltip: 'Add new item',
      child: Icon(Icons.add));
}

Widget buildList(BuildContext context) {
  ItemListViewModel viewModel = _vm(context);
  return StreamBuilder<List<ElapsedItem>>(
    stream: viewModel.items,
    builder: (context, snapshot) {
      int count = snapshot.data != null ? snapshot.data!.length : 0;
      if (count == 0) {
        return buildEmptyView(context);
      } else {
        return buildListFromItems(context, snapshot.data!, viewModel);
      }
    },
  );
}

Widget buildEmptyView(BuildContext context) {
  return Center(
    child: Text("Nothing to see here"),
  );
}

Widget buildListFromItems(
  BuildContext context,
  List<ElapsedItem> items,
  ItemListViewModel viewModel,
) {
  return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500, childAspectRatio: goldenRatio),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return CardItem(item, () => viewModel.remove(item));
      });
}

double goldenRatio = 1.61803398875;
