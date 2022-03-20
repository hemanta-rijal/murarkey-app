import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/AppConstants.dart';

/**
 * Created by Suman Prasad Neupane on 3/15/2022.
 */
class HearderWidget extends StatelessWidget {
  final String title;
  final String desc;

  HearderWidget({
    Key key,
    @required this.title,
    @required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: MediaQuery.of(context).size.width),
        textView1(
          title: "${title}",
          textSize: 2.7,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: AppConstants.appColor.whiteColor,
        ),
        SizedBox(height: 16),
        textView1(
          title: "${desc}",
          textSize: 2,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.normal,
          color: AppConstants.appColor.whiteColor,
        ),
      ],
    );
  }
}
