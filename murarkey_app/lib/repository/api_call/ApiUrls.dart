/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class ApiUrls {
  // http://newweb.murarkey.com/api/banners/homepage-1

  //For HTTPS
  static final String HTTPS_BASE_URL = "www.newweb.murarkey.com";

  //For HTTP
  static final String BASE_URL = "http://newweb.murarkey.com";
  static final String ROOT_API_URL = "/api";

  //For Auth
  static final String LOGIN_URL = ROOT_API_URL + "/auth/login";
  static final String REGISTER_URL = ROOT_API_URL + "/auth/register";

  //For User
  static final String ABOUT_ME = ROOT_API_URL + "/me";

  static final String HOME_PAGE_BANNER_URL = ROOT_API_URL + "/banners/homepage-1";
  static final String CATEGORY_URL = ROOT_API_URL + "/categories";
  static final String PARLOR_URL = ROOT_API_URL + "/featured-parlours";
  static final String BRAND_URL = ROOT_API_URL + "/featured-brands";

  //For Product
  static final String PRODUCT_DETAIL = ROOT_API_URL + "/products/";
  static final String PRODUCT_SEARCH = ROOT_API_URL + "/product/search";

  //For our services
  static final String OUR_SERVICES = ROOT_API_URL + "/services";
  static final String OUR_SERVICES_CATEGORIES = ROOT_API_URL +"/servicecategory/get-tree";

  //For
  static final String JOIN_PARLOR_PROFESSION = ROOT_API_URL + "/join-parlour-profession";
  static final String CART = ROOT_API_URL + "/cart";
  static final String CART_LIST = ROOT_API_URL + "/cart";

  static final String ADD_TO_WISHLIST = ROOT_API_URL + "/wishlist";
  static final String GET_ALL_WISHLIST = ROOT_API_URL + "/wishlist";

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
}
