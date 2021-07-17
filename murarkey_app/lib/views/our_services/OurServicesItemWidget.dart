import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'widget/card_items/ServiceCardItemWidget.dart';
import 'error/ServiceNotAvailableWidget.dart';
import 'package:murarkey_app/views/our_services/widget/ServicesItemTabViewWidget.dart';
import 'package:murarkey_app/views/our_services/widget/ServicesSubItemTabViewWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/10/2021.
 */
class OurServicesItemWidget extends StatefulWidget {
  final String title;
  final List<OurServicesSubModel> servicesList;

  const OurServicesItemWidget({Key key, this.servicesList, this.title})
      : super(key: key);

  @override
  _OurServicesItemWidgetState createState() =>
      _OurServicesItemWidgetState(title: title, servicesList: servicesList);
}

class _OurServicesItemWidgetState
    extends CustomStatefulWidgetState<OurServicesItemWidget> {
  final String title;
  final List<OurServicesSubModel> servicesList;

  _OurServicesItemWidgetState({this.title, this.servicesList});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget appBar = AppBarWidget(
      title: title,
      mainAxisAlignment: MainAxisAlignment.center,
      backgroundColor: AppConstants.appColor.backgroundColor2,
      backArrowColor: AppConstants.appColor.primaryColor,
      textColor: AppConstants.appColor.blackColor,
      backArrowSize: 25.0,
      titleSize: 2.3,
      setElevation: false,
      widget: Container(),
    );

    List<Widget> renderSubPageItems(int position) {
      List<Widget> widgetList = new List();

      if (servicesList[position].child.length == 0) {
        widgetList.add(ServiceNotAvailableWidget());
      }

      for (int i = 0; i < servicesList[position].child.length; i++) {
        widgetList.add(
          Container(
            color: AppConstants.appColor.backgroundColor2,
            child: ServiceCardItemWidget(
              model: servicesList[position].child[i],
              cardTappedAt:
                  (List<ServicesCategoryListsModel> modelList, int pos) {
                Map<String, dynamic> arguments = new Map();
                arguments["initialPosition"] = pos;
                arguments["modelList"] = modelList;
                arguments["appBarTitle"] = servicesList[position].child[i].name;
                NavigateRoute.pushNamedWithArguments(
                    context, NavigateRoute.OUR_SERVICES_ITEM_DETAIL, arguments);
              },
            ),
          ),
        );
      }
      return widgetList.toList();
    }

    List<Widget> renderPageItems() {
      List<Widget> widgetList = new List();

      if (servicesList.length == 0) {
        widgetList.add(ServiceNotAvailableWidget());
      }
      for (int i = 0; i < servicesList.length; i++) {
        widgetList.add(
          Container(
            child: ServicesSubItemTabViewWidget(
              modelList: servicesList[i].child,
              pagesLists: renderSubPageItems(i),
            ),
          ),
        );
      }
      return widgetList.toList();
    }

    Widget builder() {
      return Container(
        color: AppConstants.appColor.backgroundColor2,
        child: ServicesItemTabViewWidget(
          appBar: appBar,
          modelList: servicesList,
          pagesLists: renderPageItems(),
        ),
      );
    }

    return render(
      childWidget: SafeArea(
        child: builder(),
      ),
    );
  }
}
