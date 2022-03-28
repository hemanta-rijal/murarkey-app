import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductDescriptionWidget extends StatefulWidget {
  final String title;
  final String body;

  ProductDescriptionWidget({Key key, @required this.title, @required this.body})
      : super(key: key);

  @override
  _ProductDescriptionWidgetState createState() =>
      _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
  @override
  Widget shortDecription(short_description) {
    return Container(
      child: Html(
        shrinkWrap: true,
        data: "${short_description}",
        style: {
          "body": Style(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
          ),
        },
        //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Product Title
              textView1(
                  title: widget.title,
                  textAlign: TextAlign.start,
                  color: AppConstants.appColor.blackColor,
                  textSize: 2.2,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 18),
              shortDecription(
                widget.body,
              ),
              // textView1(
              //     title: widget.body,
              //     textAlign: TextAlign.start,
              //     color: AppConstants.appColor.blackColor,
              //     textSize: 1.8,
              //     fontWeight: FontWeight.normal),
            ],
          ),
        ),
      ),
    );
  }
}
