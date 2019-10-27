import 'package:flutter/widgets.dart';

abstract class ViewModel {
  void onDispose() {}
}

class ModelProvider<T extends ViewModel> extends StatefulWidget {
  final T model;
  final Widget child;

  ModelProvider({@required this.model, @required this.child})
      : assert(model != null),
        assert(child != null);

  @override
  State<StatefulWidget> createState() =>
      ModelProviderState<T>(model: model, child: child);

  static T getModel<T>(BuildContext context) {
    return _InheritedModel.findPerType(context);
  }
}

class ModelProviderState<T extends ViewModel> extends State<ModelProvider<T>> {
  final T model;
  final Widget child;

  ModelProviderState({@required this.model, @required this.child})
      : assert(model != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) =>
      _InheritedModel<T>(object: model, child: child);

  @override
  void dispose() {
    model.onDispose();
    super.dispose();
  }
}

class ObjectProvider<T> extends StatelessWidget {
  final T model;

  final Widget child;

  ObjectProvider({@required this.model, @required this.child})
      : assert(model != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return _InheritedModel<T>(object: model, child: child);
  }

  static T getObject<T>(BuildContext context) {
    return _InheritedModel.findPerType(context);
  }
}

class _InheritedModel<T> extends InheritedWidget {
  final T object;

  _InheritedModel({Key key, Widget child, T object})
      : this.object = object,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedModel<T> oldWidget) => true;

  static T findPerType<T>(BuildContext context) {
    final Type type = _type<_InheritedModel<T>>();
    Widget widget =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    if (widget == null) {
      throw ProviderError(type);
    } else {
      return (widget as _InheritedModel<T>).object;
    }
  }

  static Type _type<T>() => T;
}

/// The error that will be thrown if the ModelProvider cannot be found in the
/// Widget tree.
class ProviderError extends Error {
  final Type _type;

  ProviderError(this._type);

  String toString() {
    return 'Error: Could not find model of type $_type';
  }
}
