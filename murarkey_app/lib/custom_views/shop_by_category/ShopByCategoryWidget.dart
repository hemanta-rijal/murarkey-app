import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

class ShopByCategoryWidget extends StatefulWidget {
  //1. list-of-horizontal-list-in-flutter
  //https://stackoverflow.com/questions/51089041/list-of-horizontal-list-in-flutter
  List<CategoryModel> modelList;
  Function(CategoryModel) onCallBack;

  ShopByCategoryWidget({Key key, @required this.modelList, this.onCallBack})
      : super(key: key);

  @override
  _ShopByCategoryWidgetState createState() => _ShopByCategoryWidgetState();
}

class _ShopByCategoryWidgetState extends State<ShopByCategoryWidget> {
  double _imageHeight = 100.0;
  double _containerHeight = 140.0;
  double _containerWidth = 120.0;

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

    buildItems() {
      return widget.modelList.map((model) {
        return InkResponse(
          onTap: () {
            widget.onCallBack(model);
          },
          child: Container(
            width: _containerWidth + 16,
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                loadImage(model.image_url),
                SizedBox(height: 4),
                Text(
                  model.name,
                  style: TextStyle(
                    color: AppConstants.appColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textMultiplier * 1.8,
                  ),
                )
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
            scrollDirection: Axis.horizontal, children: buildItems()));

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 16, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
            title: AppConstants.constants.SHOP_BY_CATEGORY,
            fontSize: 2.2,
          ),
          SizedBox(height: 16),
          horizontalList1,
        ],
      ),
    );
  }
}
