import 'package:flutter/material.dart';

class Commons{

  /*
  * This method is used to print logs and toast messages
  * */
  static void toastMessage(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


}