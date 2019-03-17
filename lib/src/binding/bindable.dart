import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'binding_helper.dart';

class Bindable {
  final Map<String, dynamic> _values = Map();
  final StreamController<String> _changeController = new StreamController.broadcast();
  Stream<String> get changeStream => _changeController.stream;

  void set<T>(String name, T value) {
    if (_values[name] == value) return;
    _values[name] = value;
    hasChanged(name);
  }

  T get<T>(String name, T defaultValue) {
    isObserved(name);
    return _values[name] as T ?? defaultValue;
  }

  String toJson() => json.encode(_values);

  close() {
    _changeController.sink.close();
  }

  @protected
  hasChanged(String name) {
    _changeController.sink.add(name);
  }

  @protected
  isObserved(String name) {
    BindingHelper.widgetListensTo(this, name);
  }
}
