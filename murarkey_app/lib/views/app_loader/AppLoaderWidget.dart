import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/8/2021.
 */
class AppLoaderWidget extends StatefulWidget {
  @override
  _AppLoaderWidgetState createState() => _AppLoaderWidgetState();
}

class _AppLoaderWidgetState extends State<AppLoaderWidget> {
  Repository _repository = new Repository();
  int apiRequestCount = 0;
  bool hasNetworkConnectivity = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    //Get all api request here
    apiRequestCount = 0;
    hasNetworkConnectivity = await Commons.checkNetworkConnectivity();
    if (!hasNetworkConnectivity) {
      setState(() {});
      return;
    }

    //About me
    //apiRequestCount++;
    var myDetails =
        await _repository.userApiRequest.getMyDetails(url: ApiUrls.ABOUT_ME);
    if (myDetails != null) {
      GlobalData.userModel = myDetails;
      //print(GlobalData.userModel.name),
    }
    //--apiRequestCount,

    // Get home page banners list
    apiRequestCount++;
    var banner = await _repository.homeApiRequest
        .getBanner(url: ApiUrls.HOME_PAGE_BANNER_URL);
    GlobalData.bannerModelList = banner;
    --apiRequestCount;

    // Get our services list
    apiRequestCount++;
    var ourServicesList = await _repository.servicesApiRequest
        .getOurServicesList(url: ApiUrls.OUR_SERVICES_CATEGORIES);
    GlobalData.ourServicesModelList = ourServicesList;
    --apiRequestCount;

    // Get our services list
    apiRequestCount++;
    var servicesCategoryList = await _repository.servicesApiRequest
        .getServicesCategoryList(url: ApiUrls.OUR_SERVICES_CATEGORIES);
    GlobalData.serviceCategoryModelList = servicesCategoryList;
    --apiRequestCount;

    // Get our services list
    apiRequestCount++;
    var popularServicesFromCategory = await _repository.servicesApiRequest
        .popularServicesFromCategory(url: ApiUrls.POPULAR_SERVICES);
    GlobalData.popularServiceCategoryModelList = popularServicesFromCategory;
    --apiRequestCount;

    // Get category list
    apiRequestCount++;
    var category =
        await _repository.homeApiRequest.getCategory(url: ApiUrls.CATEGORY_URL);
    GlobalData.categoryModelList = category;
    --apiRequestCount;

    // Get parlor list
    apiRequestCount++;
    var parlor =
        await _repository.homeApiRequest.getParlor(url: ApiUrls.PARLOR_URL);
    GlobalData.parlorModelList = parlor;
    --apiRequestCount;

    // Get Brand list
    apiRequestCount++;
    var brand =
        await _repository.homeApiRequest.getBrand(url: ApiUrls.BRAND_URL);
    GlobalData.brandModelList = brand;
    --apiRequestCount;

    apiRequestCount++;
    var countryList =
        await _repository.addressApi.getCountryList(url: ApiUrls.COUNTRY_LIST);
    if (countryList != null) {
      GlobalData.countryListModel = countryList;
    }
    --apiRequestCount;

    apiRequestCount++;
    var paymentList = await _repository.paymentWithApi
        .getPaymentList(url: ApiUrls.PAYMENT_METHODS);
    if (paymentList != null) {
      if (paymentList["status"] == 200) {
        GlobalData.paywith = paymentList;
        print("getPaymentList");
        print(GlobalData.paywith);
      }
    }
    --apiRequestCount;

    // Get Skin varient list
    apiRequestCount++;
    var skinVarient = await _repository.bestProductForYouApi
        .getSkinVarient(url: ApiUrls.PRODUCT_VARIENT);
    GlobalData.skinVarientModelList = skinVarient;
    print(
        "skinVarientModelList--------> ${GlobalData.skinVarientModelList.length}");
    --apiRequestCount;

    apiRequestCount++;
    var menu = await _repository.navigationDrawerApi
        .getMenu(url: ApiUrls.HEADER_MENU_URL);
    GlobalData.menuItemModelList = menu;
    print("MenuItemModelList--------> ${GlobalData.menuItemModelList.length}");
    --apiRequestCount;
    this.setState(() {});

    //After getting data delay for 5-6 sec
    print("apiRequestCount ${apiRequestCount}");
    if (apiRequestCount == 0 && hasNetworkConnectivity) {
      Future.delayed(Duration(milliseconds: 1000), () {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalData.size = MediaQuery.of(context).size;

    if (!hasNetworkConnectivity) {
      return ConnectivityWidget(
        retry: () {
          hasNetworkConnectivity = true;
          setState(() {});
          Future.delayed(Duration(seconds: 1), () {
            loadData();
          });
        },
      );
    }

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Loader2Widget(radius: 30, dotRadius: 5.0),
          ),
        ),
      ),
    );
  }
}
