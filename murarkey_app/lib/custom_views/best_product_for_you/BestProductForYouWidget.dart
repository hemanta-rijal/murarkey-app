import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/AppConstants.dart';

/**
 * Created by Suman Prasad Neupane on 3/15/2022.
 */
class BestProductForYouWidget extends StatefulWidget {
  Function callback;

  BestProductForYouWidget({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  _BestProductForYouWidgetState createState() =>
      _BestProductForYouWidgetState();
}

class _BestProductForYouWidgetState extends State<BestProductForYouWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12, left: 4, right: 4),
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(left: 4, right: 4),
            child: UnderlinedTextViewWidget(
              title: AppConstants.constants.BEST_PRODUCT_FOR_YOU,
              fontSize: 2.2,
            ),
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              widget.callback();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textView1(
                  title: "Select Products",
                  textSize: 1.6,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: AppConstants.appColor.textColor3,
                ),
                SizedBox(width: 6),
                svgImageAssert(
                  imgUrl: "images/arrows/ic_right_arrow.svg",
                  color: AppConstants.appColor.textColor3,
                ),
                //SizedBox(width: 8),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
