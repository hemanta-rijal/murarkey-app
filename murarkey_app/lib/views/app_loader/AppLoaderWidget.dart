import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    //Get all api request here

    //About me
    //apiRequestCount++;
    _repository.userApiRequest
        .getMyDetails(url: ApiUrls.ABOUT_ME)
        .then((value) =>
    {
      if (value != null)
        {
          GlobalData.userModel = value,
          //print(GlobalData.userModel.name),
        },
      //--apiRequestCount,
      this.setState(() {}),
    });

    // Get home page banners list
    apiRequestCount++;
    _repository.homeApiRequest
        .getBanner(url: ApiUrls.HOME_PAGE_BANNER_URL)
        .then((value) =>
    {
      GlobalData.bannerModelList = value,
      --apiRequestCount,
      this.setState(() {}),
    });

    // Get our services list
    apiRequestCount++;
    _repository.servicesApiRequest
        .getOurServicesList(url: ApiUrls.OUR_SERVICES_CATEGORIES)
        .then((value) =>
    {
      GlobalData.ourServicesModelList = value,
      --apiRequestCount,
      this.setState(() {}),
    });

    // Get category list
    apiRequestCount++;
    _repository.homeApiRequest
        .getCategory(url: ApiUrls.CATEGORY_URL)
        .then((value) =>
    {
      GlobalData.categoryModelList = value,
      --apiRequestCount,
      this.setState(() {}),
    });

    // Get parlor list
    apiRequestCount++;
    _repository.homeApiRequest
        .getParlor(url: ApiUrls.PARLOR_URL)
        .then((value) =>
    {
      GlobalData.parlorModelList = value,
      --apiRequestCount,
      this.setState(() {}),
    });

    // Get Brand list
    apiRequestCount++;
    _repository.homeApiRequest
        .getBrand(url: ApiUrls.BRAND_URL)
        .then((value) =>
    {
      GlobalData.brandModelList = value,
      --apiRequestCount,
      this.setState(() {}),
    });

    apiRequestCount++;
    _repository.addressApi
        .getCountryList(url: ApiUrls.COUNTRY_LIST)
        .then((value) =>
    {
      if (value != null)
        {
          GlobalData.countryListModel = value,
        },
      --apiRequestCount,
      this.setState(() {}),
    });

    apiRequestCount++;
    _repository.paymentWithApi
        .getPaymentList(url: ApiUrls.PAYMENT_METHODS)
        .then((value) =>
    {
      if (value != null)
        {
          if (value["status"] == 200)
            {
              GlobalData.paywith = value,
              print("getPaymentList"),
              print(GlobalData.paywith),
            },
        },
      --apiRequestCount,
      this.setState(() {}),
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalData.size = MediaQuery.of(context).size;

    //After getting data delay for 5-6 sec
    print("apiRequestCount ${apiRequestCount}");
    if (apiRequestCount == 0) {
      Future.delayed(Duration(milliseconds: 5000), () {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
      });
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
