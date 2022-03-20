import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';
import 'package:progress_dialog/progress_dialog.dart' as ProgressDialog;

/**
 * Created by Suman Prasad Neupane on 12/16/2021.
 * https://stackoverflow.com/questions/58093029/show-a-loading-indicator-while-waiting-for-api-response
 * https://pub.dev/packages/progress_dialog
 */
class ProgressDialogLoader {
  _Body _body;
  BuildContext _context;
  BuildContext _dismissingContext;
  bool _barrierDismissible = true;
  bool _isShowing = false;

  ProgressDialogLoader({@required BuildContext context}) {
    this._context = context;
  }

  void show() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isShowing) {
        _body = _Body();
        showDialog(
          context: _context,
          barrierDismissible: _barrierDismissible,
          builder: (BuildContext ctx) {
            this._dismissingContext = ctx;
            this._isShowing = true;
            return WillPopScope(
              child: _body,
              onWillPop: () async => _barrierDismissible,
            );
          },
        );
      }
    });
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    if (_dismissingContext != null) {
      Navigator.pop(_dismissingContext);
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // Aligns the container to center
      child: Container(
        // A simplified version of dialog.
        // width: 56.0,
        // height: 56.0,
        child: Loader2Widget(
          radius: 30,
          dotRadius: 5.0,
        ), //CircularProgressIndicator(),
      ),
    );
  }
}
