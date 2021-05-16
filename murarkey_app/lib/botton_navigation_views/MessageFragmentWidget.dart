import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class MessagesFragmentWidget extends StatefulWidget {
  @override
  _MessagesFragmentWidgetState createState() => _MessagesFragmentWidgetState();
}

class _MessagesFragmentWidgetState
    extends CustomStatefulWidgetState<MessagesFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return render(
        childWidget: Container(
      child: Center(
        child: Text(
          'Index 1: Messages',
        ),
      ),
    ));
  }
}
