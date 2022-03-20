import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductTypeWidget extends StatefulWidget {
  final String title;
  final String body;
  double titleFontSize;
  double bodyFontSize;

  ProductTypeWidget(
      {Key key,
      @required this.title,
      @required this.body,
      double titleFontSize,
      double bodyFontSize})
      : super(key: key) {
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
                    fontWeight: FontWeight.bold),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
