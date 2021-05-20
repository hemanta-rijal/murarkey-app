import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

dropDown1(
    {@required List modelList,
    @required value,
    margin,
    @required Function(dynamic) onChange}) {
  return Container(
      height: 35,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 1, color: AppConstants.appColor.greyColor),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return new DropdownButtonHideUnderline(
            child: new DropdownButton(
          items: modelList.map<DropdownMenuItem<String>>((model) {
            return new DropdownMenuItem<String>(
              value: model,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: textView(model),
              ),
            );
          }).toList(),
          value: value,
          isExpanded: true,
          onChanged: (changedValue) {
            onChange.call(changedValue);
          },
        ));
      }));
}

textView(String title) {
  return Text(
    title,
    style: TextStyle(
      color: AppConstants.appColor.textColor,
      fontWeight: FontWeight.normal,
      fontSize: SizeConfig.textMultiplier * 2.0,
    ),
  );
}
