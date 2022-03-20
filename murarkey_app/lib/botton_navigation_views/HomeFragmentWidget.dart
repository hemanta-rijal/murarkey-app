import 'package:flutter/rendering.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/best_product_for_you/BestProductForYouWidget.dart';
import 'package:murarkey_app/custom_views/book_an_appointment/BookAnAppointmentWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/AlertDialogWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/ProgressDialogLoader.dart';
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
import 'package:murarkey_app/repository/models/our_services/OurServicesModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';

class HomeFragmentWidget extends StatefulWidget {
  //https://stackoverflow.com/questions/50250789/expanded-widgets-must-be-placed-inside-flex-widgets

  @override
  _HomeFragmentWidgetState createState() => _HomeFragmentWidgetState();
}

class _HomeFragmentWidgetState
    extends CustomStatefulWidgetState<HomeFragmentWidget> {
  List<HomepageBannerModel> bannerModelList = GlobalData.bannerModelList;
  List<CategoryModel> categoryModelList = GlobalData.categoryModelList;
  List<ParlorModel> parlorModelList = GlobalData.parlorModelList;
  List<BrandModel> brandModelList = GlobalData.brandModelList;
  List<OurServicesModel> ourServicesModelList = GlobalData.ourServicesModelList;

  @override
  void initState() {
    super.initState();
    // GlobalData.ourServicesModelList.forEach((e) {
    //   ourServicesModelList.add(e);
    // });
    // WidgetsBinding.instance.addPostFrameCallback(
    //         (_) => _showStartDialog()
    // );
    // var p = ProgressDialogLoader(context: context);
    // p.show();
    // Future.delayed(Duration(seconds: 20), (){
    //   if(p.isShowing()){
    //     p.hide();
    //   }
    // });
  }

  _showStartDialog() {
    AlertDialogWidget.showAlertDialog(
      context: context,
      title: "Pay with ",
      message: "Are you sure you want to pay with",
      okText: "Continue",
      cancelText: "Cancel",
      okCallback: () async {
        Navigator.pop(context);
      },
      cancleCallback: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void didChangeDependencies() {
    //ProgressDialogLoader(context: context).show();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget divider(modelList) {
      return modelList != null && modelList.length > 0
          ? Container(
              color: Colors.black38,
              width: double.infinity,
              height: 8,
            )
          : Container();
    }

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
                      context,
                      NavigateRoute.SEARCH,
                      arguments,
                    );
                  },
                  onTextChange: (value) {
                    print(value);
                  }),

              SizedBox(height: 4),

              //Image Slider
              bannerModelList != null
                  ? ImageSliderWidget(
                      bannerModelList: bannerModelList,
                      backgroundColor: AppConstants.appColor.backgroundColor2,
                      bannerHeight: screenSize.height / 6.5,
                      imageFit: BoxFit.fill,
                    )
                  : Container(),

              //Our Services
              ourServicesModelList != null && ourServicesModelList.length > 0
                  ? OurServicesWidget(
                      modelList: ourServicesModelList,
                    )
                  : Container(),

              //Shop by category
              //divider(categoryModelList),
              categoryModelList != null && categoryModelList.length > 0
                  ? ShopByCategoryWidget(
                      modelList: categoryModelList,
                      onCallBack: (categoryModel) {
                        Map<String, dynamic> arguments = new Map();
                        arguments["categoryModelList"] = categoryModelList;
                        arguments["brandModelList"] = brandModelList;
                        arguments["slugType"] = SearchWidget.TYPE_CATEGORY_SLUG;
                        arguments["slug"] = categoryModel.slug;
                        arguments["categoryModel"] = categoryModel;
                        NavigateRoute.pushNamedWithArguments(
                          context,
                          NavigateRoute.SEARCH,
                          arguments,
                        );
                      },
                    )
                  : Container(),

              //Popular Parlours
              //divider(parlorModelList),
              parlorModelList != null && parlorModelList.length > 0
                  ? PopularParloursWidget(
                      modelList: parlorModelList,
                      onCallBack: (ParlorModel parlorModel) {
                        Map<String, dynamic> arguments = new Map();
                        arguments["parlorModel"] = parlorModel;
                        NavigateRoute.pushNamedWithArguments(
                          context,
                          NavigateRoute.POPULAR_PARLOUR_DETAIL,
                          arguments,
                        );
                      },
                    )
                  : Container(),

              //Schedule Premium Service
              // SchedulePremiumServiceWidget(
              //     modelList: Datas.schedulePremiumList),

              //Shop by Brands
              //divider(brandModelList),
              brandModelList != null && brandModelList.length > 0
                  ? ShopByBrandsWidget(
                      modelList: brandModelList,
                      onCallBack: (BrandModel brandModel) {
                        Map<String, dynamic> arguments = new Map();
                        arguments["categoryModelList"] = categoryModelList;
                        arguments["brandModelList"] = brandModelList;
                        arguments["slugType"] = SearchWidget.TYPE_BRAND_SLUG;
                        arguments["slug"] = brandModel.slug;
                        arguments["brandModel"] = brandModel;
                        NavigateRoute.pushNamedWithArguments(
                          context,
                          NavigateRoute.SEARCH,
                          arguments,
                        );
                      },
                    )
                  : Container(),

              //Best Product For You
              BestProductForYouWidget(
                callback: () {
                  NavigateRoute.pushNamed(
                    context,
                    NavigateRoute.SKIN_TONE,
                  );
                },
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
      childWidget: builder(),
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      floatingActionButton: FBFloatingButton().fab(),
    );
  }
}
