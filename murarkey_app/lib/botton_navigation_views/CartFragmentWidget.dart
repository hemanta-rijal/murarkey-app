import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class CartFragmentWidget extends StatefulWidget {
  @override
  _CartFragmentWidgetState createState() => _CartFragmentWidgetState();
}

class _CartFragmentWidgetState
    extends CustomStatefulWidgetState<CartFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return render(
        childWidget: Container(
      child: Center(
        child: Text(
          'Index 2: Cart',
        ),
      ),
    ));
  }
}
