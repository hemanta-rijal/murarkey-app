import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorServicesModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/error/ServiceNotAvailableWidget.dart';
import 'package:murarkey_app/views/poplar_parlors/widget/ParlorCardItemWidget.dart';

import 'PopularParloursDetailController.dart';

class PopularParloursDetailWidget extends StatefulWidget {
  final ParlorModel parlorModel;

  const PopularParloursDetailWidget({Key key, this.parlorModel})
      : super(key: key);

  @override
  _PopularParloursDetailWidgetState createState() =>
      _PopularParloursDetailWidgetState(parlorModel);
}

class _PopularParloursDetailWidgetState
    extends CustomStatefulWidgetState<PopularParloursDetailWidget> {
  final ParlorModel parlorModel;
  Widget appBar;
  PopularParloursDetailController _controller =
      new PopularParloursDetailController();

  _PopularParloursDetailWidgetState(this.parlorModel);

  getParloursDetail() async {
    EasyLoadingView.show(message: 'Loading...');
    try {
      _controller.parlorModel =
          await _controller.getParloursDetail(parlorModel.id);
    } catch (e) {}
    EasyLoadingView.dismiss();
    if (_controller.parlorModel != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    appBar = AppBarWidget(
      title: parlorModel.name,
      mainAxisAlignment: MainAxisAlignment.center,
      backgroundColor: AppConstants.appColor.backgroundColor2,
      backArrowColor: AppConstants.appColor.primaryColor,
      textColor: AppConstants.appColor.blackColor,
      backArrowSize: 25.0,
      titleSize: 2.3,
      setElevation: false,
      widget: Container(),
    );
    getParloursDetail();
    super.initState();
  }

  Widget loadBannerImage() {
    if (_controller.parlorModel != null) {
      return Image.network(
        _controller.parlorModel.featureImageUrl,
        width: GlobalData.size.width,
        height: GlobalData.size.width * 0.55,
        fit: BoxFit.cover,
      );
    }
    return Container();
  }

  Widget shortDecription() {
    if (_controller.parlorModel != null) {
      return Container(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          textView1(
              title: "Introduction",
              textAlign: TextAlign.start,
              color: AppConstants.appColor.blackColor,
              textSize: 2.4,
              fontWeight: FontWeight.bold),
          Html(
            shrinkWrap: true,
            data: "${_controller.parlorModel.about}",
            style: {
              "body": Style(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
              ),
            },
            //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
          ),
        ],
      ));
    }

    return Container();
  }

  Widget info(title, message) {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: RichText(
              text: TextSpan(
                text: "${title}: ",
                style: TextStyle(
                  color: AppConstants.appColor.primaryDarkColor,
                  fontSize: SizeConfig.textMultiplier * 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
            flex: 2,
            child: RichText(
              text: TextSpan(
                text: message,
                style: TextStyle(
                  color: AppConstants.appColor.blackColor,
                  fontSize: SizeConfig.textMultiplier * 1.8,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget personalInfo() {
    if (_controller.parlorModel != null) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Contact Details",
                style: TextStyle(
                  color: AppConstants.appColor.blackColor,
                  fontSize: SizeConfig.textMultiplier * 2.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),
            info("Phone", _controller.parlorModel.phone),
            info("Email", _controller.parlorModel.email),
            info("Address", _controller.parlorModel.address),
            info("show ", "social medias "),
          ],
        ),
      );
    }

    return Container();
  }

  Widget serviceNotAvailableWidget() {
    return Container(
      height: 400,
      child: Center(
        child: ServiceNotAvailableWidget(),
      ),
    );
  }

  Widget renderSubPageItems() {
    if (_controller.parlorModel == null) {
      return serviceNotAvailableWidget();
    } else if (_controller.parlorModel.services.length == 0) {
      return serviceNotAvailableWidget();
    } else if (_controller.parlorModel.services.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          //Product Title
          Container(
            margin: EdgeInsets.only(left: 16),
            child: textView1(
              title: "Our Services",
              textAlign: TextAlign.start,
              color: AppConstants.appColor.blackColor,
              textSize: 2.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          ParlorCardItemWidget(
            modelList: _controller.parlorModel.services,
            cardTappedAt:
                (List<ServicesCategoryListsModel> modelList, int pos) {
              Map<String, dynamic> arguments = new Map();
              arguments["initialPosition"] = pos;
              arguments["modelList"] = modelList;
              arguments["appBarTitle"] = parlorModel.name;
              NavigateRoute.pushNamedWithArguments(
                  context, NavigateRoute.OUR_SERVICES_ITEM_DETAIL, arguments);
            },
          )
        ],
      );
    }
    return serviceNotAvailableWidget();
  }

  Widget divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget builder() {
      return Container(
        color: AppConstants.appColor.backgroundColor2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppConstants.appColor.backgroundColor2,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBar,
                    SizedBox(height: 8),
                  ],
                ),
              ),
              loadBannerImage(),
              _controller.parlorModel != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shortDecription(),
                              divider(),
                              SizedBox(height: 24),
                              personalInfo(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              renderSubPageItems(),
            ],
          ),
        ),
      );
    }

    return render(
      childWidget: Scaffold(
        body: SafeArea(
          child: new LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              //physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    child: builder(),
                  )),
            );
          }),
        ),
      ),
    );
  }
}
