import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

textView1({String title, margin, double textSize, FontWeight fontWeight}) {
  textSize = textSize == null ? 2.0 : textSize;
  fontWeight = fontWeight ?? FontWeight.normal;
  return Container(
    margin: margin ?? EdgeInsets.zero,
    child: Text(
      title,
      style: TextStyle(
        color: AppConstants.appColor.textColor,
        fontWeight: fontWeight,
        fontSize: SizeConfig.textMultiplier * textSize,
      ),
    ),
  );
}
