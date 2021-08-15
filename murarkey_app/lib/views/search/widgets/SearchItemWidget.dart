import 'package:murarkey_app/custom_views/text_view/RichTextWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

class SearchItemWidget extends StatefulWidget {
  final List<ProductDetailModel> modelList;
  final Function(ProductDetailModel) onCallback;

  SearchItemWidget({Key key, @required this.modelList, this.onCallback})
      : super(key: key);

  @override
  _SearchItemWidgetState createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  double _imageHeight = 96.0;
  double _containerHeight = 160.0;
  double _containerWidth = 120.0;

  var _crossAxisCount = 2;
  var _aspectRatio = 0.82;
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

    buildItems(ProductDetailModel model) {
      return Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16, left: 8, right: 8),
              child: Column(
                children: [
                  loadImage(model.images[0].imageUrl),
                  SizedBox(height: 4),
                  Text(
                    model.category.name.toUpperCase(),
                    style: TextStyle(
                      color: AppConstants.appColor.greyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 1.8,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    model.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppConstants.appColor.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.textMultiplier * 1.6,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Expanded(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  color: Colors.green[500],
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: RichText(
                    text: TextSpan(
                      text: "NRP. " + model.price_after_discount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appColor.whiteColor,
                        fontSize: SizeConfig.textMultiplier * 1.8,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: " "),
                        TextSpan(
                          text: "NRP. " + model.price.toString(),
                          style: TextStyle(
                            color: AppConstants.appColor.blackColor,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1.2,
                            decorationColor: AppConstants.appColor.redColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget list1 = new Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      //height: _containerHeight,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.modelList.length,
        physics: const NeverScrollableScrollPhysics(),
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
                child: InkResponse(
                  onTap: () {
                    widget.onCallback(widget.modelList[position]);
                  },
                  child: buildItems(widget.modelList[position]),
                ),
              ),
            ),
          );
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
