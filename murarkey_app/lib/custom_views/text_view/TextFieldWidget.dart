import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */
textField1({String hint, @required controller, margin, keyboardType}) {
  keyboardType = keyboardType == null? TextInputType.text: keyboardType;
  return Container(
    //width: double.infinity,
    margin: margin,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(width: 1, color: AppConstants.appColor.greyColor),
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 8),
      child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.0,
              color: AppConstants.appColor.textColor),
          decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.0,
                color: AppConstants.appColor.textColor3),
          )),
    ),
  );
}

textField2({String hint, @required controller, margin}) {
  return Container(
    margin: margin,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(width: 1, color: AppConstants.appColor.greyColor),
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 8),
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLines: 10,
          minLines: 6,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.0,
              color: AppConstants.appColor.textColor),
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

textFieldDisableKeyboard({String hint, @required controller, margin, Color borderColor, TextAlign textAlign, double height, double fontSize}) {
  height = height == null? 35: height;
  fontSize = fontSize == null? SizeConfig.textMultiplier * 2.0: fontSize;
  borderColor = borderColor == null? AppConstants.appColor.greyColor: borderColor;
  textAlign = textAlign == null? TextAlign.left: textAlign;
  return Container(
    height: height,
    //width: double.infinity,
    margin: margin,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(width: 1, color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 8),
      child: TextField(
          enableInteractiveSelection: false, // will disable paste operation
          enabled: false,
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize,
              color: AppConstants.appColor.textColor),
          decoration: new InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(8.0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.0,
                color: AppConstants.appColor.textColor3),
          )),
    ),
  );
}
