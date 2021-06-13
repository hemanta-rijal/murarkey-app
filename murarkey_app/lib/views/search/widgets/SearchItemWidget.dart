import 'package:murarkey_app/custom_views/text_view/RichTextWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

class SearchItemWidget extends StatefulWidget {
  final List<dynamic> modelList;

  SearchItemWidget({Key key, @required this.modelList}) : super(key: key);

  @override
  _SearchItemWidgetState createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  double _imageHeight = 96.0;
  double _containerHeight = 160.0;
  double _containerWidth = 120.0;

  var _crossAxisCount = 3;
  var _aspectRatio = 0.60;
  var _cardSize = 50.0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _imageHeight,
      );
    }

    buildItems(model) {
      return Container(
          //height: _containerHeight,
          //width: _containerWidth + 16,
          child: Column(
        children: [
          loadImage("http://murarkey.surge.sh/img/products/rustic8.jpg"),
          SizedBox(height: 4),
          Text(
            "Towel",
            style: TextStyle(
              color: AppConstants.appColor.greyColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.2,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "Rustic Art Juniper Lavender Shampoo For Men 175gms",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppConstants.appColor.blackColor,
              fontWeight: FontWeight.normal,
              fontSize: SizeConfig.textMultiplier * 1.4,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Rs 300 ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppConstants.appColor.primaryColor,
                fontSize: SizeConfig.textMultiplier * 1.6,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "Rs 350",
                    style: TextStyle(
                      color: AppConstants.appColor.textColor3,
                      fontSize: SizeConfig.textMultiplier * 1.4,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 1.2,
                      decorationColor: AppConstants.appColor.redColor,
                    )),
              ],
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ));
    }

    Widget list1 = new Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      //height: _containerHeight,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.modelList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount, childAspectRatio: _aspectRatio),
        itemBuilder: (context, position) {
          return Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(top: 2),
              child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: buildItems(widget.modelList[position]),
                  )));
        },
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
      child: Column(
        children: [
          list1,
        ],
      ),
    );
  }
}
