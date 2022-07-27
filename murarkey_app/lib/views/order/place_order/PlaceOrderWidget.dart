import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/AlertDialogWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/payments/EsewaPayment.dart';
import 'package:murarkey_app/utils/payments/PayPalPayment.dart';
import 'package:murarkey_app/views/order/place_order/widgets/OrderItemTotalWidget.dart';
import 'package:murarkey_app/views/order/place_order/widgets/PaymentCardWidget.dart';
import 'package:murarkey_app/views/order/place_order/widgets/PaymentWithWidget.dart';
import 'package:murarkey_app/views/order/place_order/widgets/ShippingAndBillingWidget.dart';

/**
 * Created by Suman Prasad Neupane on 6/21/2021.
 */

class PlaceOrderWidget extends StatefulWidget {
  @override
  _PlaceOrderWidgetState createState() => _PlaceOrderWidgetState();
}

class _PlaceOrderWidgetState
    extends CustomStatefulWidgetState<PlaceOrderWidget> {
  Repository _repository = new Repository();
  CartModel cartModel = new CartModel();
  var paywith;

  bool isTheirContentData = false;

  Size size;
  var _cardSize = 100.0;
  var appBarHeight = 50.0;

  //transaction id for only esewa
  var transactionId = 0;

  _PlaceOrderWidgetState() {
    paywith = GlobalData.paywith;
    loadData();
  }

  loadData() async {
    await _repository.productRequestApi
        .getCartList(url: ApiUrls.CART)
        .then((value) => {
              cartModel = value,
              loadContent(),
              this.setState(() {}),
            });
  }

  loadContent() {
    if (cartModel != null) {
      print("CartFrag");
      if (cartModel.getContent().length > 0) {
        //viewModel.loadProductTextLists(cartModel.getContent());
        isTheirContentData = true;
        //calculateTransactionFromTimeStamp();
      } else {
        isTheirContentData = false;
      }
    }
  }

  calculateTransactionFromTimeStamp() {
    List<ContentCartModel> m = cartModel.getContent();
    for (int i = 0; i < m.length; i++) {
      transactionId += m[i].options["timestamp"];
    }

    print("transactionId= ${transactionId}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;

    Widget loadImage(String imgUrl) {
      _cardSize = size.width * 0.25;
      if (imgUrl != null) {
        return Image.network(
          imgUrl,
          fit: BoxFit.cover,
          height: _cardSize,
        );
      }

      return Container(
        height: _cardSize,
        width: _cardSize,
      );
    }

    Widget buildItems(ContentCartModel content, int index) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        padding: EdgeInsets.only(top: 4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loadImage(content.options["image"]),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width - _cardSize - 88,
                          child: textView1(
                              title: content.name,
                              textAlign: TextAlign.start,
                              color: AppConstants.appColor.blackColor,
                              textSize: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        textView1(
                            title:
                                "${content.options["product_type"].toString().toUpperCase()}",
                            textAlign: TextAlign.start,
                            color: AppConstants.appColor.greyColor,
                            textSize: 2.0,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 2),
                        textView1(
                            title: "Rs. ${content.price.toString()} per item",
                            textAlign: TextAlign.start,
                            color: AppConstants.appColor.greyColor,
                            textSize: 2.0,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            text: "Order Placed: ",
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: SizeConfig.textMultiplier * 2.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${content.qty.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppConstants.appColor.primaryLightColor,
                                  fontSize: SizeConfig.textMultiplier * 2.0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: textView1(
                                  title:
                                      "Total: Rs. ${content.subtotal.toString()}",
                                  textAlign: TextAlign.right,
                                  color:
                                      AppConstants.appColor.primaryLightColor,
                                  textSize: 2.3,
                                  fontWeight: FontWeight.bold,
                                  margin: EdgeInsets.only(right: 8)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget horizontalList2 = ListView.builder(
        //padding: const EdgeInsets.only(left: 4, right: 4),
        itemCount: cartModel.getContent().length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //margin: EdgeInsets.only(top: 4, bottom: 4),
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(),
              child: buildItems(cartModel.getContent()[index], index),
            ),
          );
        });

    paymentDialog(int position) {
      return AlertDialogWidget.showAlertDialog(
        context: context,
        title: "Pay with ${paywith["data"][position]["name"]}",
        message:
            "Are you sure you want to pay with ${paywith["data"][position]["name"]}",
        okText: "Continue",
        cancelText: "Cancel",
        okCallback: () async {
          Navigator.pop(context);
          String type = paywith["data"][position]["name"].toLowerCase();

          if (type == "esewa") {
            //EsewaPayment().init(context, 0.0);

            int total = cartModel.total;
            int subTotal = cartModel.subTotal;
            int tax = cartModel.tax;
            String pid = await _repository.esewaApi
                .getEsewaPID(url: ApiUrls.ESEWA_PID_URL);
            //await _repository.userTokenPref.getUserSession();
            print("pid--------------> ${pid}");

            Map<String, dynamic> arguments = new Map();
            arguments["pid"] = pid;
            // UniqueKey().toString();

            arguments["tAmt"] = total.toDouble();
            arguments["amt"] = subTotal.toDouble();
            arguments["txAmt"] = tax.toDouble();

            arguments["psc"] = 0.0;
            arguments["pdc"] = 0.0;

            //"http://demo.murarkey.com/api/esewa-verify";
            arguments["su"] = ApiUrls.ESEWA_SUCCESS_URL;
            arguments["fu"] = ApiUrls.ESEWA_FAILURE_URL;

            NavigateRoute.pushNamedWithArguments(
                context, NavigateRoute.ESEWA_EPAY_PAYMENT, arguments);

            //hidden

          } else if (type == "paypal") {
            PayPalPayment().payBalance(
                repository: _repository,
                amount: cartModel.total.toString(),
                displayName: GlobalData.userModel.name,
                currencyCode: PayPalPayment.USA_CODE,
                onCallback: (bool value) {
                  Commons.toastMessage(
                      context, value ? "Payment Successful" : "Payment Failed");
                });
          }
        },
        cancleCallback: () {
          Navigator.pop(context);
        },
      );
    }

    buildView() {
      var u = GlobalData.userModel;
      var b = u.billing_details;
      String bAddress = "${b.city} ${b.state} ${b.zip}";

      var s = u.shipment_details;
      String sAddress = "${s.city} ${s.state} ${s.zip}";
      return Column(
        children: [
          Container(
            //margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              //borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ShippingAndBillingWidget.get(
                  title: "Billing and Shipping Address",
                  address: bAddress,
                  email: "${u.email}",
                  phoneNo: "${u.phone}",
                  size: size,
                  context: context,
                ),
                SizedBox(height: 2),
              ],
            ),
          ),
          SizedBox(height: 2),
          //Shipping and Billing
          isTheirContentData == true ? horizontalList2 : Container(),
          isTheirContentData == true
              ? Container(
                  margin: EdgeInsets.only(top: 2),
                  child: OrderItemTotalWidget(
                    subTotal: "${cartModel.subTotal}",
                    shippingCharge: "${cartModel.shippingAmount}",
                    tax: "${cartModel.tax}",
                    total: "${cartModel.total}",
                  ),
                )
              : Container(),
          (paywith != null)
              ? PaymentWithWidget(
                  paywith: paywith,
                  onTap: (int position) {
                    paymentDialog(position);
                  },
                )
              : Container(),
        ],
      );
    }

    return renderWithAppBar(
      appBarText: "Your Order",
      appBarHeight: appBarHeight,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
    );
  }
}
