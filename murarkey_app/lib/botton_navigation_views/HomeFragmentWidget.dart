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
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/repository/server/home_page/HomeApiRequest.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
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
  Repository _repository = new Repository();
  List<HomepageBannerModel> bannerModelList;
  List<CategoryModel> categoryModelList;
  List<ParlorModel> parlorModelList;
  List<BrandModel> brandModelList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    //Get all api request here

    // Get home page banners list
    await _repository.homeApiRequest
        .getBanner(url: ApiUrls.HOME_PAGE_BANNER_URL)
        .then((value) => {
              bannerModelList = value,
              this.setState(() {}),
            });

    // Get category list
    await _repository.homeApiRequest
        .getCategory(url: ApiUrls.CATEGORY_URL)
        .then((value) => {
              categoryModelList = value,
              this.setState(() {}),
            });

    // Get parlor list
    await _repository.homeApiRequest
        .getParlor(url: ApiUrls.PARLOR_URL)
        .then((value) => {
              parlorModelList = value,
              this.setState(() {}),
            });

    // Get Brand list
    await _repository.homeApiRequest
        .getBrand(url: ApiUrls.BRAND_URL)
        .then((value) => {
              brandModelList = value,
              this.setState(() {}),
            });
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
                  onTap: () {
                    Map<String, dynamic> arguments = new Map();
                    arguments["categoryModelList"] = categoryModelList;
                    arguments["brandModelList"] = brandModelList;
                    NavigateRoute.pushNamedWithArguments(
                        context, NavigateRoute.SEARCH, arguments);
                  },
                  onTextChange: (value) {
                    print(value);
                  }),

              SizedBox(height: 4),

              //Image Slider
              bannerModelList != null
                  ? ImageSliderWidget(bannerModelList: bannerModelList)
                  : Container(),

              //Our Services
              OurServicesWidget(
                iconLists: Datas.ourServicesList,
              ),

              //Shop by category
              categoryModelList != null
                  ? ShopByCategoryWidget(
                      modelList: categoryModelList,
                      onCallBack: (categoryModel) {
                        Map<String, dynamic> arguments = new Map();
                        arguments["categoryModelList"] = categoryModelList;
                        arguments["brandModelList"] = brandModelList;
                        arguments["categoryModel"] = categoryModel;
                        NavigateRoute.pushNamedWithArguments(
                            context, NavigateRoute.SEARCH, arguments);
                      },
                    )
                  : Container(),

              //Popular Parlours
              parlorModelList != null
                  ? PopularParloursWidget(
                      modelList: parlorModelList,
                      onCallBack: (ParlorModel parlorModel) {
                        Map<String, dynamic> arguments = new Map();
                        arguments["parlorModel"] = parlorModel;
                        // NavigateRoute.pushNamedWithArguments(
                        //     context, NavigateRoute.PRODUCT_DETAIL, arguments);
                      },
                    )
                  : Container(),

              //Schedule Premium Service
              SchedulePremiumServiceWidget(
                  modelList: Datas.schedulePremiumList),

              //Shop by Brands
              brandModelList != null
                  ? ShopByBrandsWidget(
                      modelList: brandModelList,
                    )
                  : Container(),

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
