import 'package:elapsed_time/model_provider.dart';
import 'package:flutter/material.dart';

import 'item/item_view.dart';
import 'main/main_bloc.dart';
import 'main/main_view.dart';

class Routes {
  static String home = '/';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition() {
  return {
    Routes.home: (context) =>
        ModelProvider<MainBloc>(model: MainBloc(), child: MainView()),
    Routes.itemDetails: (context) => ItemView()
  };
}
