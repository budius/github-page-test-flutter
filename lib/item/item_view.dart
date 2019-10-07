import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'item_model.dart';

class ItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ItemModel>(
        model: ItemModel(ModalRoute.of(context).settings.arguments),
        child: ScopedModelDescendant<ItemModel>(
          builder: (context, child, model) => Scaffold(
            body: Center(
              child: Text(model.text),
            ),
          ),
        ));
  }
}
