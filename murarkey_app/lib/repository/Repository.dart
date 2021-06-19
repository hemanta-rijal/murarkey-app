import 'package:murarkey_app/repository/server/auth_request/AuthApiRequest.dart';
import 'package:murarkey_app/repository/server/home_page/HomeApiRequest.dart';
import 'package:murarkey_app/repository/server/others/JoinProfessionalApi.dart';
import 'package:murarkey_app/repository/server/product/ProductRequestApi.dart';
import 'package:murarkey_app/repository/share_preferences/LocalSharePref.dart';
import 'package:murarkey_app/repository/share_preferences/UserTokenPref.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

class Repository {
  HomeApiRequest homeApiRequest = new HomeApiRequest();
  AuthApiRequest authApiRequest = new AuthApiRequest();
  ProductRequestApi productRequestApi = new ProductRequestApi();
  JoinProfessionalApi joinProfessionalApi = new JoinProfessionalApi();

  //Local Storage
  UserTokenPref userTokenPref = new UserTokenPref();
}
