import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/models/best_product_for_you/SkinVarientModel.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/navigation_drawer/MenuItemModel.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/repository/models/service_category/ServiceCategoryModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/themes/AppTheme.dart';
import 'package:murarkey_app/themes/colors/AppColor.dart';

class AppConstants {
  static _Constants get constants => _Constants();

  static GlobalData globaldata;

  static AppColor get appColor => AppColor();

  static AppTheme get appTheme => AppTheme();
}

class GlobalData {
  static List<HomepageBannerModel> bannerModelList;
  static List<CategoryModel> categoryModelList;
  static List<ServiceCategoryModel> serviceCategoryModelList;
  static List<ServicesCategoryListsModel> popularServiceCategoryModelList;
  static List<ParlorModel> parlorModelList;
  static List<BrandModel> brandModelList;
  static List<OurServicesModel> ourServicesModelList;
  static List<SkinVarientModel> skinVarientModelList;
  static Map<String, dynamic> skinVarientModelValue = {};
  static List<MenuItemModel> menuItemModelList;

  static UserModel userModel = new UserModel();
  static List<CountryModel> countryListModel = new List();
  static var paywith;

  static Size size;
}

class _Constants {
  String get APP_NAME => "Murarkey";

  // Login and Register
  String get EMAIL => "Email";

  String get PASSWORD => "Password";

  String get CONFIRM_PASSWORD => "Confirm Password";

  String get LOG_IN => 'LOG IN';

  String get REGISTER => 'REGISTER';

  String get SEND_A_RESET_LINK => 'Send a Reset Link';

  String get FORGET_PASSWORD => "Lost your password?";

  String get BACK_TO_LOGIN => "Back To Login";

  String get FIND_YOUR_ACCOUNT => "Find Your Account";

  String get ENTER_YOUR_EMAIL_ACCOUNT => "Please enter your email to search for your account.";

  String get REMEMBER_ME => "Remember me";

  String get PRIVACY_POLICY_MSG =>
      '© Your personal data will be used to support your experience throughout this app, to manage access to your account as described in our';

  String get PRIVACY_POLICY => " privacy policy.";

  String get OUR_SERVICES => "Our Home Services";

  String get SHOP_BY_CATEGORY => "Shop Product By Category";

  String get Popular_Parlours => "Popular Training Centers";

  String get SCHEDULE_PREMIUM_SERVICE => "Schedule Premium Service at Home";

  String get SHOP_BY_BRANDS => "Shop Products By Brands";
  String get POPULAR_SERVICE_AT_HOME => "Popular Services at Home";

  String get BEST_PRODUCT_FOR_YOU => "Find the Best Product for you, According to your\nSkin Type";

  String get BUTTON_SCHEDULE => "Schedule";

  String get BUTTON_SUBMIT => "Submit";

  String get BUTTON_SAVE_CHANCES => "Save Changes";

  String get BUTTON_SAVE_ADDRESS => "Save Address";

  String get NO_TIME_GO_SALON => "Are you a beauty professional?";

  String get MURARKEY_PROVIDES =>
      "Join Murarkey Pro Team";

  String get BOOK_AN_APPOINTMENT => " Join us";

  //Social Media
  String get FACEBOOK_PAGE_ID => "395985173802030";

  String get FACEBOOK_PAGE_NAME => "EagleyeTechnology";
}

class _PaddingConstants {}
