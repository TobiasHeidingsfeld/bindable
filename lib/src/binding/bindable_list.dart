import 'dart:collection';

import 'package:bindable/bindable.dart';

class BindableList<T> with ListMixin<T>, Bindable {
  final List<T> _list = new List();

  static const String listChanged = "ListChanged";

  @override
  int get length {
    isObserved(listChanged);
    return _list.length;
  }

  @override
  set length(int newLength) {
    hasChanged(listChanged);
    _list.length = newLength;
  }

  @override
  T operator [](int index) {
    isObserved(listChanged);
    return _list[index];
  }

  @override
  void operator []=(int index, T value) {
    hasChanged(listChanged);
    _list[index] = value;
  }
}
