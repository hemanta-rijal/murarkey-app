import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/utils/Imports.dart';

class ShopByBrandsWidget extends StatefulWidget {
  List modelList;

  ShopByBrandsWidget({Key key, @required this.modelList}) : super(key: key);

  @override
  _ShopByBrandsWidgetState createState() => _ShopByBrandsWidgetState();
}

class _ShopByBrandsWidgetState extends State<ShopByBrandsWidget> {
  double _imageHeight = 100.0;
  double _containerHeight = 100.0;
  double _containerWidth = 180.0;

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
        return Container(
          width: _containerWidth,// + 16,
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child:  loadImage(model['imgUrl']),
        );
      }).toList();
    }

    Widget horizontalList1 = new Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        height: _containerHeight,
        child: new ListView(
            scrollDirection: Axis.horizontal, children: buildItems()));

    return Container(
      margin: EdgeInsets.only(top: 28, left: 8, right: 8, bottom: 28),
      child: Column(
        children: [
          UnderlinedTextViewWidget(title: AppConstants.constants.SHOP_BY_BRANDS),
          SizedBox(height: 12),
          horizontalList1,
        ],
      ),
    );
  }
}