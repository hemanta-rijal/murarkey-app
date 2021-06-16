import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */
class ProductBannerWidget extends StatefulWidget {
  final String imageUrl;

  ProductBannerWidget({Key key, @required this.imageUrl}) : super(key: key);

  @override
  _ProductBannerWidgetState createState() => _ProductBannerWidgetState();
}

class _ProductBannerWidgetState extends State<ProductBannerWidget> {
  static const _cardSize = 220.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Container(
        width: double.infinity,
        height: _cardSize,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppConstants.appColor.whiteColor,
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ]));
  }
}
