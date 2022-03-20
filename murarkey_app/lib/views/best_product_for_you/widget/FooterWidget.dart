import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/AppConstants.dart';

/**
 * Created by Suman Prasad Neupane on 3/15/2022.
 */
class FooterWidget extends StatelessWidget {
  final String leftButtonName;
  final String rightButtonName;
  final Function leftButtonTap;
  final Function rightButtonTap;
  final int noOfDots;
  final int dotActiveAt;

  FooterWidget({
    Key key,
    @required this.leftButtonName,
    @required this.rightButtonName,
    @required this.noOfDots,
    @required this.dotActiveAt,
    @required this.leftButtonTap,
    @required this.rightButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget singleDot(Color color) {
      return Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
    }

    Widget dotsList() {
      List<Widget> dots = [];
      for (int i = 1; i <= noOfDots; i++) {
        if (i == dotActiveAt) {
          dots.add(singleDot(
            AppConstants.appColor.whiteColor,
          ));
        } else {
          dots.add(singleDot(
            AppConstants.appColor.greyColor,
          ));
        }
      }

      return Row(
        children: dots,
      );
    }

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              leftButtonTap();
            },
            child: textView1(
              title: "${leftButtonName}",
              textSize: 2,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
              color: AppConstants.appColor.whiteColor,
            ),
          ),
        ),
        SizedBox(width: 16),
        dotsList(),
        SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () {
              rightButtonTap();
            },
            child: textView1(
              title: "${rightButtonName}",
              textSize: 2,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
              color: AppConstants.appColor.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
