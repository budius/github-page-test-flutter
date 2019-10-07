import 'package:flutter/material.dart';

import 'item/item_view.dart';
import 'main/main_view.dart';

class Routes {
  static String home = '/';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition() {
  return {
    Routes.home: (context) => MainView(),
    Routes.itemDetails: (context) => ItemView()
  };
}
