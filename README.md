# Bindable

Bindable is a state managment library that is powerful and easy to use. It will become extendable in the future and get many useful plugins to do complex tasks in a simple plugin.

## Getting Started

Instead of using the values of your data directly you make every class with mutuable data Bindable by using the mixin `with Bindable`

For properties use getters and setters like:

~~~~
int get counter => get("counter", 0);
set counter(int v) => set("counter", v);
~~~~

Then every property of these Bindable Models will update everywhere in your View automatically when you use a `BindingWidget` or the `Binding` Builder to have mor granular control.

The classic Flutter counter example:

~~~~
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
~~~~

In a real world

## Todos and Plans

[ ] toJson and fromJson for automatic JSON Binding

[ ] Plugin System

[ ] implement [Flutter Architecture Samples](https://fluttersamples.com/) Todo App with Bindable

[ ] much more