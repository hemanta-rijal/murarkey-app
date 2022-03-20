/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class ApiUrls {
  // http://newweb.murarkey.com/api/banners/homepage-1

  //For HTTPS
  static final String HTTPS_BASE_URL = "www.newweb.murarkey.com";

  //For HTTP
  //"https://demo.murarkey.com";//"http://newweb.murarkey.com";
  static final String BASE_URL = "https://murarkey.com";
  static final String ROOT_API_URL = "/api";

  //For Auth
  static final String LOGIN_URL = ROOT_API_URL + "/auth/login";
  static final String REGISTER_URL = ROOT_API_URL + "/auth/register";
  static final String LOGOUT_URL = ROOT_API_URL + "/auth/logout";

  //For User
  static final String ABOUT_ME = ROOT_API_URL + "/me";
  static final String UPDATE_PROFILE = ROOT_API_URL + "/my-account/update";

  //For Password
  static final String CHANGE_PASSWORD = ROOT_API_URL +"/password/change";

  static final String HOME_PAGE_BANNER_URL = ROOT_API_URL + "/banners/mobile_app"; //"/banners/homepage-1";
  static final String CATEGORY_URL = ROOT_API_URL + "/categories";
  static final String PARLOR_URL = ROOT_API_URL + "/featured-parlours";
  static final String BRAND_URL = ROOT_API_URL + "/featured-brands";

  //For Parlor
  static final String PARLOR_DETAIL_URL = ROOT_API_URL + "/parlours/";

  //For Product
  static final String PRODUCT_DETAIL = ROOT_API_URL + "/products/";
  static final String PRODUCT_SEARCH = ROOT_API_URL + "/product/search";

  //For our services
  static final String OUR_SERVICES = ROOT_API_URL + "/services";
  static final String OUR_SERVICES_CATEGORIES = ROOT_API_URL +"/servicecategory/get-tree";
  static String SERVICES_CATEGORY_LIST(String id){
    return ROOT_API_URL + "/servicecategory/${id}/services";
  }

  //For
  static final String JOIN_PARLOR_PROFESSION = ROOT_API_URL + "/join-parlour-profession";
  static final String CART = ROOT_API_URL + "/cart";
  static final String CART_LIST = ROOT_API_URL + "/cart";

  static final String ADD_TO_WISHLIST = ROOT_API_URL + "/wishlist";
  static final String GET_ALL_WISHLIST = ROOT_API_URL + "/wishlist";
  static final String PROCEED_ALL_TO_CART_WISHLIST = ROOT_API_URL +  "/wishlist/proceedalltocart";

  //For Payment
  static final String PAYMENT_METHODS = ROOT_API_URL + "/payment_methods";

  //For Address
  static final String COUNTRY_LIST = ROOT_API_URL + "/countries";

  //http://newweb.murarkey.com/api//my-account/shipping-details
  //For Payment Card Address
  static final String PAYMENT_BILLING_ADDRESS = ROOT_API_URL + "/my-account/billing-details";
  static final String PAYMENT_SHIPPING_ADDRESS = ROOT_API_URL + "/my-account/shipment-details";

  //For Payment Esewa
  static final String PAYMENT_ESWEA_CALLACK = BASE_URL + ROOT_API_URL + "/payment_verify";

 //For Wallet
  static final String GET_WALLET_HISTORY = ROOT_API_URL + "/my-account/wallet";

  //For My order
  static final String MY_ORDER = ROOT_API_URL + "/user/my-orders";

  //For Pay pal
  static final String PAYPAL_TRANSACTION = ROOT_API_URL + "/paypal_transaction";

  //For Esewa
  //http://demo.murarkey.com/api/esewa-verify?q=su
  static final String ESEWA_SUCCESS_URL = BASE_URL + ROOT_API_URL + "/auth/esewa-verify?q=su";
  static final String ESEWA_FAILURE_URL = BASE_URL + ROOT_API_URL + "/auth/esewa-verify?q=fu";
  static final String ESEWA_PID_URL = ROOT_API_URL + "/auth/esewa-pid";
}
