import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductTypeWidget extends StatefulWidget {
  final String title;
  final String body;

  ProductTypeWidget({Key key, @required this.title, @required this.body})
      : super(key: key);

  @override
  _ProductTypeWidgetState createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<ProductTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.title,
        style: TextStyle(
            color: AppConstants.appColor.primaryDarkColor,
            fontSize: SizeConfig.textMultiplier * 1.6,
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: widget.body,
              style: TextStyle(
                color: AppConstants.appColor.textColor3,
                fontSize: SizeConfig.textMultiplier * 1.55,
              )),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
