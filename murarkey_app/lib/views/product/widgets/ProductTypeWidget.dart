import 'package:flutter/gestures.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/SlugManager.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductTypeWidget extends StatefulWidget {
  final String title;
  final String body;
  List<dynamic> bodyList;
  double titleFontSize;
  double bodyFontSize;
  final Function(String slug) onTabSlugItem;

  ProductTypeWidget({
    Key key,
    @required this.title,
    @required this.body,
    List<dynamic> bodyList,
    double titleFontSize,
    double bodyFontSize,
    @required this.onTabSlugItem,
  }) : super(key: key) {
    this.bodyList = bodyList == null ? [] : bodyList;

    this.titleFontSize =
        titleFontSize == null ? SizeConfig.textMultiplier * 2.0 : titleFontSize;
    this.bodyFontSize =
        bodyFontSize == null ? SizeConfig.textMultiplier * 1.8 : bodyFontSize;
  }

  @override
  _ProductTypeWidgetState createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<ProductTypeWidget> {
  @override
  Widget build(BuildContext context) {
    List<TextSpan> showString() {
      List<TextSpan> textLists = [];
      int i = 0;
      widget.bodyList.forEach((element) {
        textLists.add(
          TextSpan(
            text: "${element}",
            style: TextStyle(
              color: AppConstants.appColor.blackColor,
              fontSize: widget.bodyFontSize,
              decoration: TextDecoration.underline,
              decorationThickness: 1.2,
              decorationColor: AppConstants.appColor.redColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //make slug
                String s = SlugManager.create(
                  string: element,
                );
                widget.onTabSlugItem(s);
              },
          ),
        );
        if (widget.bodyList.length > 1 && widget.bodyList.length - 1 != i) {
          textLists.add(
            TextSpan(text: ", "),
          );
        }
        i++;
      });

      return textLists;
    }

    Widget showListOrString() {
      if (widget.bodyList != null && widget.bodyList.length > 0) {
        return Expanded(
          flex: 2,
          child: RichText(
            text: TextSpan(
              text: widget.body,
              style: TextStyle(
                color: AppConstants.appColor.blackColor,
                fontSize: widget.bodyFontSize,
              ),
              children: showString(),
            ),
            textAlign: TextAlign.justify,
          ),
        );
      }
      return Expanded(
        flex: 2,
        child: RichText(
          text: TextSpan(
              text: widget.body,
              style: TextStyle(
                color: AppConstants.appColor.blackColor,
                fontSize: widget.bodyFontSize,
              )),
          textAlign: TextAlign.justify,
        ),
      );
    }

    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: RichText(
              text: TextSpan(
                text: widget.title,
                style: TextStyle(
                  color: AppConstants.appColor.primaryDarkColor,
                  fontSize: widget.titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          showListOrString(),
        ],
      ),
    );
  }
}
