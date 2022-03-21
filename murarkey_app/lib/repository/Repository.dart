import 'package:murarkey_app/repository/server/ParlorApiRequest.dart';
import 'package:murarkey_app/repository/server/auth_request/AuthApiRequest.dart';
import 'package:murarkey_app/repository/server/best_product_for_you/BestProductForYouApi.dart';
import 'package:murarkey_app/repository/server/home_page/HomeApiRequest.dart';
import 'package:murarkey_app/repository/server/order/OrderApiService.dart';
import 'package:murarkey_app/repository/server/others/AddressApi.dart';
import 'package:murarkey_app/repository/server/others/JoinProfessionalApi.dart';
import 'package:murarkey_app/repository/server/others/PaymentWithApi.dart';
import 'package:murarkey_app/repository/server/others/UserApiRequest.dart';
import 'package:murarkey_app/repository/server/payment/EsewaApi.dart';
import 'package:murarkey_app/repository/server/payment_card_address/PaymentCardAddressApi.dart';
import 'package:murarkey_app/repository/server/payment/PayPalApi.dart';
import 'package:murarkey_app/repository/server/product/ProductRequestApi.dart';
import 'package:murarkey_app/repository/server/product/WishlistRequestApi.dart';
import 'package:murarkey_app/repository/server/services/ServicesApiRequest.dart';
import 'package:murarkey_app/repository/server/wallet/WalletApiRequest.dart';
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
  UserApiRequest userApiRequest = new UserApiRequest();
  PaymentCardAddressApi paymentCardAddressApi = new PaymentCardAddressApi();
  AddressApi addressApi = new AddressApi();
  WishlistRequestApi wishlistRequestApi = new WishlistRequestApi();
  ServicesApiRequest servicesApiRequest = new ServicesApiRequest();
  OrderApiService orderApiService = new OrderApiService();
  ParlorApiRequest parlorApiRequest = new ParlorApiRequest();
  BestProductForYouApi bestProductForYouApi = new BestProductForYouApi();

  //payments
  PayPalApi payPalApi = new PayPalApi();
  WalletApiRequest walletApiRequest = new WalletApiRequest();
  PaymentWithApi paymentWithApi = new PaymentWithApi();
  EsewaApi esewaApi = new EsewaApi();


  //Local Storage
  UserTokenPref userTokenPref = new UserTokenPref();
}
