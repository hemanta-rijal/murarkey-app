import 'package:flutter/rendering.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/book_an_appointment/BookAnAppointmentWidget.dart';
import 'package:murarkey_app/custom_views/our_services/OurServicesWidget.dart';
import 'package:murarkey_app/custom_views/popular_parlours/PopularParloursWidget.dart';
import 'package:murarkey_app/custom_views/schedule_premium_service/SchedulePremiumServiceWidget.dart';
import 'package:murarkey_app/custom_views/shop_by_brands/ShopByBrandsWidget.dart';
import 'package:murarkey_app/custom_views/shop_by_category/ShopByCategoryWidget.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/utils/Imports.dart';

class HomeFragmentWidget extends StatefulWidget {
  //https://stackoverflow.com/questions/50250789/expanded-widgets-must-be-placed-inside-flex-widgets

  @override
  _HomeFragmentWidgetState createState() => _HomeFragmentWidgetState();
}

class _HomeFragmentWidgetState
    extends CustomStatefulWidgetState<HomeFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    builder() {
      return new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(children: [
                  SearchBarWidget(
                      textHint: 'Search by Service or Product',
                      onTextChange: (value) {
                        print(value);
                      }),

                  SizedBox(height: 4),

                  ImageSliderWidget(imgList: Datas.imgSliderList),

                  //Our Services
                  OurServicesWidget(
                    iconLists: Datas.ourServicesList,
                  ),

                  //Shop by category
                  ShopByCategoryWidget(
                    modelList: Datas.shopByCategoryList,
                  ),

                  //Popular Parlours
                  PopularParloursWidget(
                    modelList: Datas.popularParlorList,
                  ),

                  //Schedule Premium Service
                  SchedulePremiumServiceWidget(
                      modelList: Datas.schedulePremiumList),

                  //Shop by Brands
                  ShopByBrandsWidget(
                    modelList: Datas.shopByBrandsList,
                  ),

                  BookAnAppointmentWidget(callback: (value) {

                  }),

                  SizedBox(height: 20,)

                ]),
              ),
            );
          });
    }

    return render(childWidget: builder());
  }
}
