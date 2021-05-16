import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class AccountFragmentWidget extends StatefulWidget {
  @override
  _AccountFragmentWidgetState createState() => _AccountFragmentWidgetState();
}

class _AccountFragmentWidgetState
    extends CustomStatefulWidgetState<AccountFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return render(
        childWidget: Container(
      child: Center(
        child: Text(
          'Index 3: Account',
        ),
      ),
    ));
  }
}
