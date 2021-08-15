import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

class ShopByBrandsWidget extends StatefulWidget {
  List<BrandModel> modelList;
  Function(BrandModel) onCallBack;

  ShopByBrandsWidget(
      {Key key, @required this.modelList, @required this.onCallBack})
      : super(key: key);

  @override
  _ShopByBrandsWidgetState createState() => _ShopByBrandsWidgetState();
}

class _ShopByBrandsWidgetState extends State<ShopByBrandsWidget> {
  // double _imageHeight = 100.0;
  // double _containerHeight = 100.0;
  // double _containerWidth = 180.0;

  double _imageHeight = 100.0;
  double _containerHeight = 100.0;
  double _containerWidth = 140.0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.contain,
        height: _imageHeight,
        width: _containerWidth + 16,
      );
    }

    // buildItems() {
    //   return widget.modelList.map((BrandModel model) {
    //     return Container(
    //       width: _containerWidth, // + 16,
    //       padding: EdgeInsets.only(left: 8.0, right: 8.0),
    //       child: InkWell(
    //         onTap: () {
    //           widget.onCallBack(model);
    //         },
    //         child: loadImage(model.imageUrl),
    //       ),
    //     );
    //   }).toList();
    // }

    buildItems() {
      return widget.modelList.map((BrandModel model) {
        return InkResponse(
          onTap: () {
            widget.onCallBack(model);
          },
          child: Container(
            width: _containerWidth + 16,
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                loadImage(model.imageUrl),
                // SizedBox(height: 4),
                // Text(
                //   model.name,
                //   style: TextStyle(
                //     color: AppConstants.appColor.textColor,
                //     fontWeight: FontWeight.bold,
                //     fontSize: SizeConfig.textMultiplier * 1.8,
                //   ),
                // )
              ],
            ),
          ),
        );
      }).toList();
    }

    Widget horizontalList1 = new Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      height: _containerHeight,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: buildItems(),
      ),
    );

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
            title: AppConstants.constants.SHOP_BY_BRANDS,
            fontSize: 2.2,
          ),
          SizedBox(height: 16),
          horizontalList1,
        ],
      ),
    );
  }
}
