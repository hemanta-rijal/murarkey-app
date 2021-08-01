import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/AlertDialogWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/payments/EsewaPayment.dart';
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
  UserModel userModel = new UserModel();
  var paywith;

  bool isTheirContentData = false;
  double _imageHeight = 88.0;

  Size size;
  var _cardSize = 100.0;
  var appBarHeight = 50.0;

  _PlaceOrderWidgetState() {
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

    await _repository.userApiRequest
        .getMyDetails(url: ApiUrls.ABOUT_ME)
        .then((value) => {
              if (value != null) {userModel = value, print(userModel.name)}
            });

    await _repository.paymentWithApi
        .getPaymentList(url: ApiUrls.PAYMENT_METHODS)
        .then((value) => {
              if (value != null)
                {
                  if (value["status"] == 200)
                    {
                      paywith = value,
                      print("getPaymentList"),
                      print(paywith),
                    },
                  this.setState(() {}),
                }
            });
  }

  loadContent() {
    if (cartModel != null) {
      print("CartFrag");
      if (cartModel.getContent().length > 0) {
        //viewModel.loadProductTextLists(cartModel.getContent());
        isTheirContentData = true;
      } else {
        isTheirContentData = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;

    Widget loadImage(String imgUrl) {
      _cardSize = size.width * 0.25;
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _cardSize,
      );
    }

    Widget buildItems(ContentCartModel content, int index) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        padding:
            EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
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
                            title: "NRP. ${content.price.toString()} per item",
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
                            textView1(
                                title:
                                    "Total: Rs. ${content.subtotal.toString()}",
                                textAlign: TextAlign.left,
                                color: AppConstants.appColor.primaryLightColor,
                                textSize: 2.3,
                                fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.only(left: 8, right: 8),
        itemCount: cartModel.getContent().length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
        okCallback: () {
          Navigator.pop(context);
          EsewaPayment().init(context, 0.0);
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
          //Shipping and Billing
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
            child:  Row(
              children: [
                Expanded(
                  child: ShippingAndBillingWidget.get(
                    title: "Billing Address",
                    address: bAddress,
                    email: "${u.email}",
                    phoneNo: "${u.phone}",
                    size: size,
                  ),
                ),
                Expanded(
                  child: ShippingAndBillingWidget.get(
                    title: "Shipping Address",
                    address: sAddress,
                    email: "${u.email}",
                    phoneNo: "${u.phone}",
                    size: size,
                  ),
                ),
              ],
            ),
          ),
          isTheirContentData == true ? horizontalList2 : Container(),
          isTheirContentData == true
              ? Container(
                  margin: EdgeInsets.only(top: 16),
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
