import 'package:elapsed_time/screens/item_create/bloc.dart';
import 'package:flutter/material.dart';

import 'package:elapsed_time/screens/item_create/view.dart';
import 'package:elapsed_time/screens/item_list/bloc.dart';
import 'package:elapsed_time/screens/item_list/view.dart';
import 'package:elapsed_time/item/item_view.dart';
import 'package:elapsed_time/item/item_bloc.dart';

import 'model_provider.dart';

class Routes {
  static String home = '/';
  static String create = '/create';
  static String itemDetails = '/item';
}

Map<String, WidgetBuilder> routesDefinition = {
  Routes.home: (context) =>
      //ModelProvider<MainBloc>(model: MainBloc(), child: MainView()),
      ModelProvider<ItemListBloc>(model: ItemListBloc(), child: ItemListView()),
  Routes.create: (context) => ModelProvider<ItemCreateBloc>(
        model: ItemCreateBloc(),
        child: ItemCreateView(),
      ),
  Routes.itemDetails: (context) => ModelProvider<ItemBloc>(
      model: ItemBloc(ModalRoute.of(context).settings.arguments),
      child: ItemView())
};
