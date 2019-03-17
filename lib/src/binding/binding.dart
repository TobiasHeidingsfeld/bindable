import 'package:flutter/widgets.dart';
import 'binding_helper.dart';

class Binding extends StatefulWidget {
  const Binding({@required this.builder, Key key})
      : assert(builder != null),
        super(key: key);

  final WidgetBuilder builder;

  @override
  State<Binding> createState() => _BindingState();
}

class _BindingState extends State<Binding> {
  @override
  Widget build(BuildContext context) {
    Widget built;
    dynamic error;
    BindingHelper.rebuildNewBindableWidget(this);
    try {
      built = widget.builder(context);
    } on Object catch (ex) {
      error = ex;
    }
    BindingHelper.buildBindableWidgetfinished(this);

    if (error != null) {
      throw error;
    }
    return built;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
