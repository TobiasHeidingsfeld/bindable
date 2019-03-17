import 'dart:async';

import 'package:flutter/widgets.dart';
import 'bindable.dart';

class BindingHelper {
  static final List<State> _buildStates = new List();
  static final Map<State, BindingConnection> _stateListeners = new Map();
  static State _activeWidgetState;

  static void rebuildNewBindableWidget(State state) {
    _buildStates.add(state);
    _activeWidgetState = state;
    getBindingHelper()
        .bindingSubscriptions
        .values
        .forEach((sub) => sub.properties.clear());
  }

  static void widgetListensTo(Bindable bindable, String name) {
    if (_activeWidgetState == null) return;

    var helper = getBindingHelper();

    var sub = getBindingSubscription(helper, bindable);

    if (!sub.properties.contains(name)) sub.properties.add(name);

    if (sub.streamSubscription == null) {
      sub.streamSubscription = bindable.changeStream.listen((data) {
        if (sub.properties.contains(data)) {
          (helper.state.context as StatefulElement).markNeedsBuild();
        }
      });
    }
  }

  static BindingSubscription getBindingSubscription(
      BindingConnection helper, Bindable bindable) {
    var sub = helper.bindingSubscriptions[bindable];
    if (sub == null) {
      sub = BindingSubscription();
      helper.bindingSubscriptions[bindable] = sub;
    }
    return sub;
  }

  static BindingConnection getBindingHelper() {
    var helper = _stateListeners[_activeWidgetState];
    if (helper == null) {
      helper = new BindingConnection(_activeWidgetState);
      _stateListeners[_activeWidgetState] = helper;
    }
    return helper;
  }

  static void buildBindableWidgetfinished(State state) {
    getBindingHelper().bindingSubscriptions.values.forEach((sub) {
      if (sub.properties.length == 0) sub.close();
    });

    _buildStates.remove(state);
    if (_buildStates.length == 0)
      _activeWidgetState = null;
    else
      _activeWidgetState = _buildStates[_buildStates.length - 1];
  }
}

class BindingConnection {
  BindingConnection(this.state);

  final State state;
  final Map<Bindable, BindingSubscription> bindingSubscriptions = new Map();
}

class BindingSubscription {
  StreamSubscription streamSubscription;
  final List<String> properties = new List();

  close() {
    streamSubscription.cancel();
    streamSubscription = null;
  }
}
