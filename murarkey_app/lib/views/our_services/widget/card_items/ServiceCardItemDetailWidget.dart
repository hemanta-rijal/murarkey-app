import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/widget/card_items/CardDeatilDescriptionWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/17/2021.
 */

class ServiceCardItemDetailWidget extends StatefulWidget {
  final String appBarTitle;
  final List<ServicesCategoryListsModel> modelList;
  final int initialPosition;

  const ServiceCardItemDetailWidget({
    Key key,
    this.modelList,
    this.initialPosition,
    this.appBarTitle,
  }) : super(key: key);

  @override
  _ServiceCardItemDetailWidgetState createState() =>
      _ServiceCardItemDetailWidgetState();
}

class _ServiceCardItemDetailWidgetState
    extends State<ServiceCardItemDetailWidget> {
  int _selectedPage = 0;
  PageController _pageController;
  double viewPortFraction = 0.9;
  double backArrowSize = 26;

  @override
  void initState() {
    print("modelList ${widget.modelList.length}");
    print("initialPosition ${widget.initialPosition}");
    _pageController = new PageController(
        initialPage: widget.initialPosition,
        viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onChange(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  Widget loadImage() {
    return Container(
      child: InkResponse(
        child: Icon(
          Icons.clear,
          size: backArrowSize,
          color: Colors.white,
        ),
        onTap: () {
          NavigateRoute.pop(context);
        },
      ),
    );
  }

  Widget appBar() {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          loadImage(),
          SizedBox(width: 32),
          RichText(
            text: TextSpan(
              text: widget.appBarTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.appColor.whiteColor,
                fontSize: SizeConfig.textMultiplier * 2.8,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          Expanded(
            flex: 1,
            child: InkResponse(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: svgImageAssert4(
                  imgUrl: "images/cart/ic_trolley.svg",
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> renderSubPageItems() {
    List<Widget> widgetList = new List();

    int size = widget.modelList.length;
    var s = MediaQuery.of(context).size;
    var widthPadding = s.width * (viewPortFraction) * 3 / 100;
    for (int i = 0; i < size; i++) {
      widgetList.add(
        Container(
          margin: EdgeInsets.only(
            left: i > 0 ? widthPadding : 0,
            right: i < size - 1 ? widthPadding : 0,
            bottom: 16,
          ),
          color: AppConstants.appColor.backgroundColor2,
          child: CardDeatilDescriptionWidget(
            parentTitle: widget.appBarTitle,
            model: widget.modelList[i],
            position: i,
          ),
        ),
      );
    }
    return widgetList.toList();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(
    //     [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppConstants.appColor.primaryDarkColor));

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: AppConstants.appColor.blackColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                appBar(),
                Expanded(
                  child: PageView(
                    onPageChanged: (int page) {
                      _onChange(page);
                    },
                    controller: _pageController,
                    children: renderSubPageItems(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
