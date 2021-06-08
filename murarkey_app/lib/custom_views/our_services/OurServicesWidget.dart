import 'package:flutter_svg/flutter_svg.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:websafe_svg/websafe_svg.dart';

//https://pub.dev/packages/flutter_svg
//https://pub.dev/packages/websafe_svg

class OurServicesWidget extends StatefulWidget {
  final List iconLists;

  OurServicesWidget({Key key, this.iconLists}) : super(key: key);

  @override
  _OurServicesWidgetState createState() => _OurServicesWidgetState();
}

class _OurServicesWidgetState extends State<OurServicesWidget> {
  @override
  Widget build(BuildContext context) {
    var _crossAxisCount = 5;
    var _aspectRatio = 0.68;
    var _cardSize = 50.0;

    print("_aspectRatio= " + _aspectRatio.toString());

    loadAssetImage(String imgUri) {
      return Container(
          color: AppConstants.appColor.primaryColor,
          padding: EdgeInsets.all(13),
          child: Image.asset(imgUri,
              color: AppConstants.appColor.whiteColor, fit: BoxFit.cover));
    }

    loagSvgImage(imgUrl) {
      return Container(
          color: AppConstants.appColor.primaryColor,
          padding: EdgeInsets.all(13),
          child: SvgPicture.network(
            imgUrl,
            color: AppConstants.appColor.whiteColor,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ));
    }

    return Container(
      margin: EdgeInsets.only(top: 24, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(title: AppConstants.constants.OUR_SERVICES),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            // new line
            //physics: NeverScrollableScrollPhysics(),
            itemCount: widget.iconLists.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                childAspectRatio: _aspectRatio),

            itemBuilder: (context, position) {
              return Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Container(
                          height: _cardSize,
                          width: _cardSize,
                          margin: EdgeInsets.all(4),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(48.0),
                              child:
                              loagSvgImage(widget.iconLists[position]["imgUrl"]))),
                      SizedBox(height: 4),
                      Text(widget.iconLists[position]["title"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.2,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.appColor.textColor))
                    ],
                  ));
            },
          )
        ],
      ),
    );
  }
}
