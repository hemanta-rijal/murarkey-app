import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */
textField1({String hint, @required controller, margin}){
  return Container(
    margin: margin,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(
          width: 1, color: AppConstants.appColor.greyColor),
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 8),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.0, color: AppConstants.appColor.textColor),
          decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )),
    ),
  );
}