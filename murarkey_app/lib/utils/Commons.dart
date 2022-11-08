import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Commons {
  /*
  * This method is used to print logs and toast messages
  * */
  static void toastMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<bool> checkNetworkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
