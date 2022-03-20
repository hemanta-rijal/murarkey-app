import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

textView1({
  String title,
  margin,
  double textSize,
  FontWeight fontWeight,
  color,
  textAlign,
  fontStyle,
}) {
  textSize = textSize == null ? 2.0 : textSize;
  fontWeight = fontWeight ?? FontWeight.normal;
  color = color ?? AppConstants.appColor.textColor;
  textAlign = textAlign ?? TextAlign.left;
  fontStyle = fontStyle ?? FontStyle.normal;

  return Container(
    margin: margin ?? null, //EdgeInses.zerot,
    child: Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: SizeConfig.textMultiplier * textSize,
      ),
    ),
  );
}

textView2({
  String title,
  margin,
  double textSize,
  FontWeight fontWeight,
  color,
  textAlign,
}) {
  textSize = textSize == null ? 2.0 : textSize;
  fontWeight = fontWeight ?? FontWeight.normal;
  color = color ?? AppConstants.appColor.textColor;
  textAlign = textAlign ?? TextAlign.left;

  return Container(
    margin: margin ?? null, //EdgeInses.zerot,
    child: Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        decorationColor: AppConstants.appColor.accentColor,
        color: color,
        fontWeight: fontWeight,
        fontSize: SizeConfig.textMultiplier * textSize,
      ),
    ),
  );
}

textViewEllipsis(
    {String title,
    margin,
    double textSize,
    FontWeight fontWeight,
    color,
    textAlign,
    fontStyle}) {
  textSize = textSize == null ? 2.0 : textSize;
  fontWeight = fontWeight ?? FontWeight.normal;
  color = color ?? AppConstants.appColor.textColor;
  textAlign = textAlign ?? TextAlign.left;
  fontStyle = fontStyle ?? FontStyle.normal;

  return Container(
    margin: margin ?? null, //EdgeInses.zerot,
    child: Text(
      title,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: SizeConfig.textMultiplier * textSize,
      ),
    ),
  );
}
