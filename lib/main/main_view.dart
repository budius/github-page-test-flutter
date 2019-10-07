import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../routes_definition.dart';
import 'main_model.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: MainModel(),
        child: ScopedModelDescendant<MainModel>(
            builder: (context, child, model) => Scaffold(
                  appBar: AppBar(
                      title: Text(
                    model.title,
                    style: TextStyle(fontFamily: 'RobotoBlack'),
                  )),
                  body: ListView.builder(
                      itemCount: model.size,
                      padding: EdgeInsets.all(16.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.itemDetails,
                                arguments: model.getItem(index)),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                model.getText(index),
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ));
                      }),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () => model.addItem(),
                      tooltip: 'Add new item',
                      child: Icon(Icons.add)),
                )));
  }
}
