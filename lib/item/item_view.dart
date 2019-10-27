import 'package:flutter/material.dart';

import '../model_provider.dart';
import 'item_bloc.dart';

class ItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemBloc bloc = ModelProvider.getModel<ItemBloc>(context);
    return StreamBuilder(
      stream: bloc.text,
      builder: (context, snapshot) => Scaffold(
        body: Center(
          child: Text(snapshot.data == null ? "" : snapshot.data),
        ),
      ),
    );
  }
}
