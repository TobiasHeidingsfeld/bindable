import 'package:flutter/widgets.dart';
import 'binding_helper.dart';

abstract class BindingWidget extends StatefulWidget {
  const BindingWidget({Key key}) : super(key: key);

  @override
  _BindingWidgetState createState() => _BindingWidgetState();

  Widget build(BuildContext context);
}

class _BindingWidgetState extends State<BindingWidget> {
  @override
  Widget build(BuildContext context) {
    Widget built;
    dynamic error;

    BindingHelper.rebuildNewBindableWidget(this);
    try {
      built = widget.build(context);
    } on Object catch (ex) {
      error = ex;
    }
    BindingHelper.buildBindableWidgetfinished(this);

    if (error != null) {
      throw error;
    }

    return built;
  }
}
