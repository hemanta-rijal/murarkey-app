import 'package:flutter_svg/flutter_svg.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';

//https://pub.dev/packages/flutter_svg
//https://pub.dev/packages/websafe_svg

class OurServicesWidget extends StatefulWidget {
  final List<OurServicesModel> modelList;

  OurServicesWidget({Key key, this.modelList}) : super(key: key);

  @override
  _OurServicesWidgetState createState() => _OurServicesWidgetState();
}

class _OurServicesWidgetState extends State<OurServicesWidget> {
  @override
  Widget build(BuildContext context) {
    var _crossAxisCount = 4;
    var _aspectRatio = 0.68;
    var _cardSize = 52.0;
    var _itemCount = widget.modelList.length;

    /*24 is for notification bar on Android*/
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    final double _childAspectRatio = itemWidth / itemHeight;

    print(
        "_childAspectRatio---> ${_childAspectRatio} \n itemHeight = ${itemHeight} itemWidth = ${itemWidth}");

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _cardSize,
      );
    }

    return Container(
      color: Colors.white,
      //margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 16, bottom: 4, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
            title: AppConstants.constants.OUR_SERVICES,
            fontSize: 2.2,
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            // new line
            physics: NeverScrollableScrollPhysics(),
            itemCount: _itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              //childAspectRatio: _aspectRatio,
              childAspectRatio: _childAspectRatio,
            ),

            itemBuilder: (context, position) {
              return Container(
                padding: EdgeInsets.all(4),
                child: InkResponse(
                  onTap: () {
                    Map<String, dynamic> arguments = new Map();
                    arguments["servicesSubModel"] =
                        widget.modelList[position].child;
                    arguments["title"] = widget.modelList[position].name;
                    NavigateRoute.pushNamedWithArguments(
                        context, NavigateRoute.OUR_SERVICES_ITEM, arguments);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.appColor.backgroundColor2),
                        margin: EdgeInsets.all(4),
                        child: Container(
                            height: _cardSize,
                            width: _cardSize,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(48.0),
                                child: loadImage(
                                    widget.modelList[position].icon))),
                      ),
                      SizedBox(height: 2),
                      Text(widget.modelList[position].name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.appColor.textColor))
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
