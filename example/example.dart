import 'package:bindable/bindable.dart';
import 'package:flutter/material.dart';

class MyApp extends BindingWidget with Bindable {
  int get counter => get("counter", 0);
  set counter(int v) => set("counter", v);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child: Text("You have pressed the button $counter times")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter++,
        child: Icon(Icons.add),
      ),
    ));
  }
}
