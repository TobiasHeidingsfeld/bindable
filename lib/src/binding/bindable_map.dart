import 'dart:collection';

import 'package:bindable/bindable.dart';

class BindableMap<K, V> with MapMixin<K, V>, Bindable {
  final Map<K, V> _map = new Map();

  static const String mapChanged = "MapChanged";

  @override
  V operator [](Object key) {
    isObserved(mapChanged);
    return _map[key];
  }

  @override
  void operator []=(K key, V value) {
    hasChanged(mapChanged);
    _map[key] = value;
  }

  @override
  void clear() {
    hasChanged(mapChanged);
    _map.clear();
  }

  @override
  Iterable<K> get keys {
    isObserved(mapChanged);
    return _map.keys;
  }

  @override
  V remove(Object key) {
    hasChanged(mapChanged);
    return _map.remove(key);
  }
}
