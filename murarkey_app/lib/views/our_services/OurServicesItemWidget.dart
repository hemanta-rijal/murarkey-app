import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
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
      for (int i = 0; i < servicesList[position].services.length; i++) {
        widgetList.add(
          Container(
            child: Center(
              child: Text("Page ${i}"),
            ),
          ),
        );
      }
      return widgetList.toList();
    }

    List<Widget> renderPageItems() {
      List<Widget> widgetList = new List();
      for (int i = 0; i < servicesList.length; i++) {
        widgetList.add(
          Container(
            child: ServicesSubItemTabViewWidget(
              modelList: servicesList[i].services,
              pagesLists: renderSubPageItems(i),
            ),
          ),
        );
      }
      return widgetList.toList();
    }

    Widget builder() {
      return Container(
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
