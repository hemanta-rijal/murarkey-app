import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
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
    _controller.parlorModel =
        await _controller.getParloursDetail(parlorModel.id);
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
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Html(
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
      );
    }

    return Container();
  }
  
  Widget info(title, message){
    return RichText(
      text: TextSpan(
        text: "${title}: ",
        style: TextStyle(
          color: AppConstants.appColor.blackColor,
          fontSize: SizeConfig.textMultiplier * 2.2,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
              text: message,
              style: TextStyle(
                color: AppConstants.appColor.blackColor,
                fontSize: SizeConfig.textMultiplier * 2.0,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget personalInfo() {
    if (_controller.parlorModel != null) {
      return Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info("Phone", _controller.parlorModel.phone),
            info("Email", _controller.parlorModel.email),
            info("Address", _controller.parlorModel.address),
          ],
        ),
      );
    }

    return Container();
  }

  Widget serviceNotAvailableWidget(){
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
      return ParlorCardItemWidget(
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
      );
    }
    return serviceNotAvailableWidget();
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
              shortDecription(),
              personalInfo(),
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
                  )
              ),
            );
          }),
        ),
      ),
    );
  }
}
