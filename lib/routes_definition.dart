import 'package:elapsed_time/old/item/item_bloc.dart';
import 'package:elapsed_time/old/item/item_view.dart';
import 'package:elapsed_time/old/main/main_bloc.dart';
import 'package:elapsed_time/old/main/main_view.dart';

import 'package:flutter/material.dart';
import 'package:elapsed_time/screens/item_create/bloc.dart';
import 'package:elapsed_time/screens/item_create/view.dart';
import 'package:elapsed_time/screens/item_list/bloc.dart';
import 'package:elapsed_time/screens/item_list/view.dart';

import 'package:elapsed_time/model_provider.dart';

class Routes {
  static String home = '/';
  static String create = '/create';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition = {
  Routes.home: (context) =>
      ModelProvider<ItemListBloc>(model: ItemListBloc(), child: ItemListView()),
  Routes.create: (context) => ModelProvider<ItemCreateBloc>(
        model: ItemCreateBloc(),
        child: ItemCreateView(),
      ),
};

Map<String, WidgetBuilder> oldRoutes = {
  Routes.home: (context) =>
      ModelProvider<MainBloc>(model: MainBloc(), child: MainView()),
  Routes.itemDetails: (context) => ModelProvider<ItemBloc>(
      model: ItemBloc(ModalRoute.of(context).settings.arguments),
      child: ItemView())
};
