import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 8/1/2021.
 */

class LoaderDialog {
  bool _isShowing = false;
  show(BuildContext context) {
    _isShowing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _Loader();
        },
      );
    });
  }

  dismiss(BuildContext context) {
    _isShowing = false;
    Navigator.pop(context);
  }

  bool isShowing(){
    return _isShowing;
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Container(
          color: Colors.transparent,
          child: Loader2Widget(radius: 30, dotRadius: 5.0)),
    );
  }
}
