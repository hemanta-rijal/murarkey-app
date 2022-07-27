import 'package:flutter/material.dart';

class ErrorDialogWidget {
  static showAlertDialog({
    BuildContext context,
    String message,
    String cancelText,
    Function() cancleCallback,
  }) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(cancelText),
      onPressed: () {
        cancleCallback();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "images/ic_login_required.png",
          height: 88,
          width: 88,
          fit: BoxFit.contain,
        ),
      ),
      content: Text(message),
      actions: [
        cancelButton,
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
