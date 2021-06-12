import 'package:flutter/rendering.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/book_an_appointment/BookAnAppointmentWidget.dart';
import 'package:murarkey_app/custom_views/fb_float_button/FBFloatingButton.dart';
import 'package:murarkey_app/custom_views/our_services/OurServicesWidget.dart';
import 'package:murarkey_app/custom_views/popular_parlours/PopularParloursWidget.dart';
import 'package:murarkey_app/custom_views/schedule_premium_service/SchedulePremiumServiceWidget.dart';
import 'package:murarkey_app/custom_views/shop_by_brands/ShopByBrandsWidget.dart';
import 'package:murarkey_app/custom_views/shop_by_category/ShopByCategoryWidget.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/server/home_page/HomeApiRequest.dart';
import '../repository/api_call/ApiRequest.dart';
import '../repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/open_social_media/OpenFacebookApp.dart';

class HomeFragmentWidget extends StatefulWidget {
  //https://stackoverflow.com/questions/50250789/expanded-widgets-must-be-placed-inside-flex-widgets

  @override
  _HomeFragmentWidgetState createState() => _HomeFragmentWidgetState();
}

class _HomeFragmentWidgetState
    extends CustomStatefulWidgetState<HomeFragmentWidget> {
  HomeApiRequest _apiRequest = new HomeApiRequest();
  List<HomepageBannerModel> bannerModelList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    //Get all api request here
    await _apiRequest.banner(path: ApiUrls.HOME_PAGE_BANNER).then((value) => {
          bannerModelList = value,
          print(bannerModelList[0].name),
        });

    setState(() {});
  }

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

              bannerModelList != null
                  ? ImageSliderWidget(bannerModelList: bannerModelList)
                  : Container(),

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

              BookAnAppointmentWidget(callback: (value) {}),

              SizedBox(
                height: 20,
              )
            ]),
          ),
        );
      });
    }

    return render(
        childWidget: builder(), floatingActionButton: FBFloatingButton().fab());
  }
}
