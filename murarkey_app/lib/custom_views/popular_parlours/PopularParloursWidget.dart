import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

class PopularParloursWidget extends StatefulWidget {
  //1. list-of-horizontal-list-in-flutter
  //https://stackoverflow.com/questions/51089041/list-of-horizontal-list-in-flutter
  List<ParlorModel> modelList;
  Function(ParlorModel) onCallBack;

  PopularParloursWidget(
      {Key key, @required this.modelList, @required this.onCallBack})
      : super(key: key);

  @override
  _PopularParloursWidgetState createState() => _PopularParloursWidgetState();
}

class _PopularParloursWidgetState extends State<PopularParloursWidget> {
  @override
  Widget build(BuildContext context) {
    double _imageHeight = 100.0;
    double _containerHeight = 200.0;
    double _containerWidth = 120.0;

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
      List<ParlorModel> list = widget.modelList.length <= 8
          ? widget.modelList
          : widget.modelList.sublist(0, 5);

      return list.map((model) {
        return Container(
          width: _containerWidth + 16,
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: InkResponse(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loadImage(model.featureImageUrl),
                SizedBox(height: 4),
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppConstants.appColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textMultiplier * 1.8,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  model.address,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: AppConstants.appColor.greyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textMultiplier * 1.6,
                  ),
                )
              ],
            ),
            onTap: () {
              widget.onCallBack(model);
            },
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
      padding: EdgeInsets.only(top: 16, bottom: 4, left: 8, right: 8),
      //margin: EdgeInsets.only(top: 24, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
            title: AppConstants.constants.Popular_Parlours,
            fontSize: 2.2,
          ),
          SizedBox(height: 12),
          horizontalList1,
          SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textView1(
                  title: "View all Parlours",
                  textSize: 1.6,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: AppConstants.appColor.textColor3,
              ),
              SizedBox(width: 6),
              svgImageAssert(
                  imgUrl: "images/arrows/ic_right_arrow.svg",
                  color: AppConstants.appColor.textColor3)
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
