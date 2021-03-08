import 'package:flutter/material.dart';
import 'package:elapsed_time/screens/item_create/view_model.dart';
import 'package:elapsed_time/screens/item_create/view.dart';
import 'package:elapsed_time/screens/item_list/view_model.dart';
import 'package:elapsed_time/screens/item_list/view.dart';

import 'package:provider/provider.dart';

class Routes {
  static String home = '/';
  static String create = '/create';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition = {
  Routes.home: (context) => Provider<ItemListViewModel>(
        create: (_) => ItemListViewModel(),
        dispose: (_, value) => value.onDispose(),
        child: ItemListView(),
      ),
  Routes.create: (context) => Provider<ItemCreateViewModel>(
        create: (_) => ItemCreateViewModel(),
        dispose: (_, value) => value.onDispose(),
        child: ItemCreateView(),
      ),
};
