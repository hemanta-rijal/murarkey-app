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
  static final String REGISTER_URL = ROOT_API_URL + "auth/register";

  static final String HOME_PAGE_BANNER_URL = ROOT_API_URL + "/banners/homepage-1";
  static final String PARLOR_URL = ROOT_API_URL + "/featured-parlours";
  static final String BRAND_URL = ROOT_API_URL + "/featured-brands";
}
