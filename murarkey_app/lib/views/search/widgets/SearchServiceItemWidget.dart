import 'package:murarkey_app/custom_views/ribbons/RibbonShapeWidget.dart';
import 'package:murarkey_app/custom_views/text_view/RichTextWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

class SearchServiceItemWidget extends StatefulWidget {
  final List<ServicesCategoryListsModel> modelList;
  final Function(ServicesCategoryListsModel, int) onCallback;
  final Function(int) onScrollBottomCallback;
  final int columnSize;

  SearchServiceItemWidget({
    Key key,
    @required this.modelList,
    @required this.columnSize,
    this.onCallback,
    this.onScrollBottomCallback,
  }) : super(key: key);

  @override
  _SearchServiceItemWidgetState createState() =>
      _SearchServiceItemWidgetState();
}

class _SearchServiceItemWidgetState extends State<SearchServiceItemWidget> {
  double _imageHeight = 120.0; //96.0;
  double _containerHeight = 160.0;
  double _containerWidth = 120.0;

  var _crossAxisCount = 2;
  var _aspectRatio = 0.82;
  var _cardSize = 50.0;

  @override
  void initState() {
    _crossAxisCount = widget.columnSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.fitWidth,
        width: double.infinity,
        height: _imageHeight,
      );
    }

    check(ServicesCategoryListsModel model) {
      if (model.price_after_discount != model.price &&
          model.discount_type == "percentage") {
        return "%";
      } else if (model.price_after_discount != model.price &&
          model.discount_type == "flat_rate") {
        return "off";
      }

      return "";
    }

    buildItems(ServicesCategoryListsModel model) {
      var paddingV = 16.0;

      if (widget.columnSize > 2) {
        paddingV == 2.0;
      }

      paddingV == 2.0;

      return Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 16, left: 8, right: 8),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       //loadImage(model.images[0].imageUrl),
            //       // SizedBox(height: 4),
            //       // Text(
            //       //   model.title.toUpperCase(),
            //       //   textAlign: TextAlign.center,
            //       //   overflow: TextOverflow.clip,
            //       //   maxLines: 3,
            //       //   style: TextStyle(
            //       //     color: AppConstants.appColor.greyColor,
            //       //     fontWeight: FontWeight.bold,
            //       //     fontSize: SizeConfig.textMultiplier * 1.8,
            //       //   ),
            //       // ),
            //       // SizedBox(
            //       //   height: 8,
            //       // ),
            //     ],
            //   ),
            // ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(4),
              alignment: Alignment.topCenter,
              child: loadImage(model.images[0].imageUrl),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 8),
                  Text(
                    model.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: TextStyle(
                      color: AppConstants.appColor.greyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 1.8,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    color: AppConstants.appColor.buttonColor3,
                    //Colors.green[500],
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
                    child: RichText(
                      text: TextSpan(
                        text: "Rs. ${model.price_after_discount.toString()} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.appColor.whiteColor,
                          fontSize: SizeConfig.textMultiplier * 1.8,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: " "),
                          model.price_after_discount != model.price &&
                                  model.discount_type == "%"
                              ? TextSpan(
                                  text: "Rs. ${model.price.toString()}  ",
                                  style: TextStyle(
                                    color: AppConstants.appColor.accentColor,
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 3,
                                    decorationColor: Colors.black,
                                  ),
                                )
                              : TextSpan(text: " "),
                          model.price_after_discount != model.price &&
                                  model.discount_type == "%"
                              ? TextSpan(
                                  text: model != null &&
                                          model.discount_rates != null
                                      ? "${model.discount_rates.toString()}%"
                                      : "",
                                  style: TextStyle(
                                    color: AppConstants.appColor.accentColor,
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 3,
                                    decorationColor: Colors.black,
                                  ),
                                )
                              : TextSpan(text: ""),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
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
          crossAxisCount: _crossAxisCount,
          //childAspectRatio: _aspectRatio,
          mainAxisExtent: 228,
        ),
        itemBuilder: (context, position) {
          var model = widget.modelList[position];

          return Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(top: 2),
            child: Stack(
              children: [
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    child: InkResponse(
                      onTap: () {
                        widget.onCallback(widget.modelList[position], position);
                      },
                      child: buildItems(widget.modelList[position]),
                    ),
                  ),
                ),
                model.price_after_discount != model.price &&
                        (model.discount_type == "percentage" ||
                            model.discount_type == "flat_rate")
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 2, top: 4),
                          child: RibbonShapeWidget(
                            text: model != null && model.discount_rates != null
                                ? "${check(model) == "%" ? "${model.discount_rates.toString()}%" : "Rs.${model.discount_rates.toString()} off"}"
                                : "",
                          ),
                        ),
                      )
                    : Container(),
              ],
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
