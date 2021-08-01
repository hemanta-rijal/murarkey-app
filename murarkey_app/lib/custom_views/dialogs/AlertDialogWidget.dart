import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/22/2021.
 */

class AlertDialogWidget {
  static showAlertDialog(
      {BuildContext context,
      String title,
      String message,
      String okText,
      String cancelText,
      Function() okCallback,
      Function() cancleCallback}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(cancelText),
      onPressed: () {
        cancleCallback();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(okText),
      onPressed: () {
        okCallback();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
