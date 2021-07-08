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
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';

class HomeFragmentWidget extends StatefulWidget {
  //https://stackoverflow.com/questions/50250789/expanded-widgets-must-be-placed-inside-flex-widgets

  @override
  _HomeFragmentWidgetState createState() => _HomeFragmentWidgetState();
}

class _HomeFragmentWidgetState
    extends CustomStatefulWidgetState<HomeFragmentWidget> {
  Repository _repository = new Repository();
  List<HomepageBannerModel> bannerModelList = GlobalData.bannerModelList;
  List<CategoryModel> categoryModelList = GlobalData.categoryModelList;
  List<ParlorModel> parlorModelList = GlobalData.parlorModelList;
  List<BrandModel> brandModelList = GlobalData.brandModelList;

  @override
  void initState() {
    super.initState();
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
