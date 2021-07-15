import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
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
  static List<ParlorModel> parlorModelList;
  static List<BrandModel> brandModelList;
  static List<OurServicesModel> ourServicesModelList;

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

  String get FORGET_PASSWORD => "Lost your password?";

  String get REMEMBER_ME => "Remember me";

  String get PRIVACY_POLICY_MSG =>
      '© Your personal data will be used to support your experience throughout this app, to manage access to your account as described in our';

  String get PRIVACY_POLICY => " privacy policy.";

  String get OUR_SERVICES => "Our Services";

  String get SHOP_BY_CATEGORY => "Shop by Category";

  String get Popular_Parlours => "Popular Parlours";

  String get SCHEDULE_PREMIUM_SERVICE => "Schedule Premium Service at Home";

  String get SHOP_BY_BRANDS => "Shop by Brands";

  String get BUTTON_SCHEDULE => "Schedule";

  String get BUTTON_SUBMIT => "Submit";

  String get BUTTON_SAVE_CHANCES => "Save Changes";

  String get BUTTON_SAVE_ADDRESS => "Save Address";

  String get NO_TIME_GO_SALON => "ARE YOU A PROFESSIONAL?";

  String get MURARKEY_PROVIDES =>
      "Murarkey provides Beauty Parlour Services at Home.";

  String get BOOK_AN_APPOINTMENT => " Join us";

  //Social Media
  String get FACEBOOK_PAGE_ID => "395985173802030";

  String get FACEBOOK_PAGE_NAME => "EagleyeTechnology";
}

class _PaddingConstants {}
