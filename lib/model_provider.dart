import 'package:flutter/widgets.dart';

class ModelProvider<T> extends StatelessWidget {
  final T model;

  final Widget child;

  ModelProvider({@required this.model, @required this.child})
      : assert(model != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return _InheritedModel<T>(model: model, child: child);
  }

  static T getModel<T>(BuildContext context) {
    final Type type = _type<_InheritedModel<T>>();
    Widget widget =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    if (widget == null) {
      throw ModelProviderError();
    } else {
      return (widget as _InheritedModel<T>).model;
    }
  }

  static Type _type<T>() => T;
}

class _InheritedModel<T> extends InheritedWidget {
  final T model;

  _InheritedModel({Key key, Widget child, T model})
      : this.model = model,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedModel<T> oldWidget) => true;
}

/// The error that will be thrown if the ModelProvider cannot be found in the
/// Widget tree.
class ModelProviderError extends Error {
  ModelProviderError();

  String toString() {
    return 'Error: Could not find the correct model.';
  }
}
