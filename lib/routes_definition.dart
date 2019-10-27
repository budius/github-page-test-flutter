import 'package:flutter/material.dart';

import 'main/main_bloc.dart';
import 'model_provider.dart';
import 'item/item_view.dart';
import 'main/main_view.dart';
import 'item/item_bloc.dart';

class Routes {
  static String home = '/';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition() {
  return {
    Routes.home: (context) =>
        ModelProvider<MainBloc>(model: MainBloc(), child: MainView()),
    Routes.itemDetails: (context) => ModelProvider<ItemBloc>(
        model: ItemBloc(ModalRoute.of(context).settings.arguments),
        child: ItemView())
  };
}
