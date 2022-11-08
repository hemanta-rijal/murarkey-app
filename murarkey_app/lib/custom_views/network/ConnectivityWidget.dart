import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

class ConnectivityWidget extends StatelessWidget {
  final String message;
  final Function() retry;

  const ConnectivityWidget({
    Key key,
    this.message,
    @required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/no_network.png",
              height: 160,
              width: 160,
              fit: BoxFit.contain,
            ),
            RichText(
              text: TextSpan(
                text: "Connect to the Internet",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppConstants.appColor.blackColor,
                  fontSize: 24,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: "You're offline. Check your connection.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: AppConstants.appColor.blackColor,
                  fontSize: 16,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            FlatButton3(
              text: "Tap to retry",
              fontSize: 16,
              textColor: AppConstants.appColor.whiteColor,
              padding: EdgeInsets.only(left: 16, right: 16),
              backgroundColor: AppConstants.appColor.primaryColor,
              buttonHeight: 45,
              buttonCurve: 20,
              fontWeight: FontWeight.w800,
              boderColor: AppConstants.appColor.whiteColor,
              //buttonWidth: 100,
              onPressedCallback: () {
                retry();
              },
            )
          ],
        ),
      ),
    );
  }
}

class Connectivity2Widget extends StatelessWidget {
  final String message;
  final Function() retry;
  final Function() cancel;

  const Connectivity2Widget({
    Key key,
    this.message,
    @required this.retry,
    @required this.cancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/no_network.png",
              height: 160,
              width: 160,
              fit: BoxFit.contain,
            ),
            RichText(
              text: TextSpan(
                text: "Connect to the Internet",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppConstants.appColor.blackColor,
                  fontSize: 24,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: "You're offline. Check your connection.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: AppConstants.appColor.blackColor,
                  fontSize: 16,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: FlatButton3(
                    text: "Cancel",
                    fontSize: 16,
                    textColor: AppConstants.appColor.whiteColor,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    backgroundColor: AppConstants.appColor.redColor,
                    buttonHeight: 45,
                    buttonCurve: 20,
                    fontWeight: FontWeight.w800,
                    boderColor: AppConstants.appColor.whiteColor,
                    //buttonWidth: 100,
                    onPressedCallback: () {
                      cancel();
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton3(
                    text: "Tap to retry",
                    fontSize: 16,
                    textColor: AppConstants.appColor.whiteColor,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    backgroundColor: AppConstants.appColor.primaryColor,
                    buttonHeight: 45,
                    buttonCurve: 20,
                    fontWeight: FontWeight.w800,
                    boderColor: AppConstants.appColor.whiteColor,
                    //buttonWidth: 100,
                    onPressedCallback: () {
                      retry();
                    },
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

class ConnectivityWidgetDialog {
  static show({
    BuildContext context,
    String message,
    String cancelText,
    Function() cancleCallback,
  }) {
    var a = Dialog(
      // The background color
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            // The loading indicator
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            // Some text
            Text('Loading...')
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return a;
      },
    );

    // // set up the buttons
    // Widget cancelButton = FlatButton(
    //   child: Text(cancelText),
    //   onPressed: () {
    //     cancleCallback();
    //   },
    // );
    //
    // // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //   // title: Container(
    //   //   alignment: Alignment.center,
    //   //   child: Image.asset(
    //   //     "images/ic_login_required.png",
    //   //     height: 88,
    //   //     width: 88,
    //   //     fit: BoxFit.contain,
    //   //   ),
    //   // ),
    //   // content: ConnectivityWidget(
    //   //   retry: () {},
    //   // ),
    //   content: Container(child: Text("k vncjkbjh"),),
    //   actions: [
    //     cancelButton,
    //   ],
    // );
    //
    // // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
  }
}
