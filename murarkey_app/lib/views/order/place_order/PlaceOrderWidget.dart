import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/custom_views/date_time_picker/DateTimePickerWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/AlertDialogWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
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

  bool useWalletAmount = false;
  TextEditingController voucherTextController = TextEditingController();
  DateTime deliveryDate;
  TimeOfDay deliveryTime;
  int walletAmount = 0;
  var total = 0.0;
  var tempWalletAmount = 0.0;
  bool loading = false;

  _PlaceOrderWidgetState() {
    paywith = GlobalData.paywith;
    EasyLoadingView.show(message: 'Loading...');
    loadData(firstLoad: true);
  }

  loadData({bool firstLoad}) async {
    try {
      await _repository.productRequestApi
          .getCartList(url: ApiUrls.CART_LIST)
          .then((value) => {
                cartModel = value,
                loadContent(),
                this.setState(() {}),
              });
      walletAmount = await _repository.walletApiRequest.getWalletInfo(
        url: ApiUrls.GET_WALLET_INFO,
      );
    } catch (e) {}
    loading = true;
    EasyLoadingView.dismiss();

    this.setState(() {
      if (cartModel != null) {
        total = double.parse("${cartModel.total}");
      }
      tempWalletAmount = walletAmount.toDouble();
    });
  }

  afterCouponApply(String couponCode, bool couponStatus) async {
    //coupon: Coupon Code
    //couponStatus: true
    Map<String, dynamic> params = Map();
    params["coupon"] = couponCode;
    params["coupon_status"] = couponStatus.toString();

    CartModel model =
        await _repository.productRequestApi.getCartListAndApplyCoupon(
      url: ApiUrls.CART_LIST,
      params: params,
    );
    print("subTotal-----> ${cartModel.subTotal}");
    print("tax-----> ${cartModel.tax}");
    print("couponDiscountPrice-----> ${cartModel.couponDiscountPrice}");
    print("total-----> ${cartModel.total}");

    this.cartModel = model;
    // this.cartModel.subTotal = model.subTotal;
    // this.cartModel.tax = model.tax;
    // this.cartModel.total = model.total;
    // this.cartModel.couponDetail = model.couponDetail;
    // this.cartModel.couponDiscountPrice = model.couponDiscountPrice;
    print("subTotal-----> ${cartModel.subTotal}");
    print("tax-----> ${cartModel.tax}");
    print("couponDiscountPrice-----> ${cartModel.couponDiscountPrice}");
    print("total-----> ${cartModel.total}");
    useYourWalletAmount();

    setState(() {});
  }

  useYourWalletAmount() {
    print("useWalletAmount-----> ${useWalletAmount}");
    if (useWalletAmount) {
      var tempTotal = total;
      if (walletAmount > total) {
        total = 0.0;
        tempWalletAmount -= tempTotal;
      } else {
        total -= walletAmount;
        tempWalletAmount = 0.0;
      }
    } else {
      total = double.parse("${cartModel.total}");
      tempWalletAmount = walletAmount.toDouble();
    }
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

  String deliveryDateTimeFormatter() {
    if (deliveryDate == null) {
      return null;
    } else {
      var date = deliveryDate.year.toString() +
          "/" +
          deliveryDate.month.toString() +
          "/" +
          deliveryDate.day.toString();
      var hour = deliveryTime.hour.toString().padLeft(2, "0");
      var minute = deliveryTime.minute.toString().padLeft(2, "0");
      var period = deliveryTime.period == DayPeriod.am ? "AM" : "PM";
      var dateTime = date + "T" + hour + ":" + minute + " " + period;
      var delivery = dateTime;
      return delivery;
    }
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
                                color: AppConstants.appColor.primaryLightColor,
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
                                color: AppConstants.appColor.primaryLightColor,
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

  Widget horizontalList2() {
    return ListView.builder(
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
  }

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
        print("paymentType-------> ${type}");

        if (type == "cash on delivery") {
          var dateTime = deliveryDateTimeFormatter();

          if (deliveryTime == null) {
            Commons.toastMessage(
                context, "Please select date and time for order delivery.");
            return;
          }

          List<String> dateTimePartition = dateTime.split("T");

          Map<String, dynamic> params = new Map();
          params["payment_method "] = paywith["data"][position]["name"];
          params["date"] = dateTimePartition[0];
          params["time"] = dateTimePartition[1];
          params["wallet_use"] = useWalletAmount;

          final result = await _repository.paymentWithApi.postCashOnDelivery(
            url: ApiUrls.PAY_WITH_CASH,
            params: params,
          );
          Commons.toastMessage(context, "${result["message"]}");
          if (result["status"]) {
            NavigateRoute.pop(context);
            NavigateRoute.pushNamed(context, NavigateRoute.RECENT_ORDER);
          }
        } else if (type == "esewa") {
          //EsewaPayment().init(context, 0.0);
          try {
            var total = cartModel.total;
            var subTotal = cartModel.subTotal;
            var tax = cartModel.tax;
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
          } catch (e) {
            Commons.toastMessage(
              context,
              "Something went wrong!\nPlease contact for support.",
            );
          }
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

  apply() async {
    var check = await Commons.checkNetworkConnectivity();
    if (!check) {
      EasyLoading.show(
        status: "",
        indicator: Connectivity2Widget(
          retry: () {
            apply();
          },
          cancel: () {
            EasyLoading.dismiss();
          },
        ),
        maskType: EasyLoadingMaskType.custom,
      );
      return;
    }else{
      if (voucherTextController.text.isNotEmpty) {
        EasyLoadingView.show(message: "Applying....");
        Map<String, dynamic> result = await _repository.couponApi.applyCoupon(
          url: ApiUrls.COUPON_CODE,
          queryParams: {
            "code": voucherTextController.text.toString().toUpperCase().trim()
          },
        );
        EasyLoadingView.dismiss();
        if (result["status"]) {
          //refresh UI
          afterCouponApply(
            voucherTextController.text.toString().toUpperCase().trim(),
            true,
          );
        }

        Commons.toastMessage(context, result["message"]);
      }
    }
  }

  buildView() {
    var u = GlobalData.userModel;
    var b = u.billing_details;
    String bAddress = ""; //"${b.city} ${b.state} ${b.zip}";
    if(b.city != null){
      bAddress += "${b.city}";
    }
    if(b.state != null){
      bAddress += " ${b.state}";
    }
    if(b.zip != null){
      bAddress += " ${b.zip}";
    }

    var s = u.shipment_details;
    //String sAddress = "${s.city} ${s.state} ${s.zip}";

    if (!loading) {
      return Container();
    }

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
        isTheirContentData == true ? horizontalList2() : Container(),
        isTheirContentData == true
            ? Container(
                margin: EdgeInsets.only(top: 2),
                child: OrderItemTotalWidget(
                  subTotal: "${cartModel.subTotal}",
                  shippingCharge: "${cartModel.shippingAmount}",
                  tax: "${cartModel.tax}",
                  total: "${total.toStringAsFixed(2)}",
                  coupon: "${cartModel.couponDiscountPrice}",
                  componentView: Column(
                    children: [
                      SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: Checkbox(
                              value: this.useWalletAmount,
                              // materialTapTargetSize:
                              //     MaterialTapTargetSize.shrinkWrap,
                              onChanged: (bool value) {
                                setState(() {
                                  this.useWalletAmount = value;
                                  useYourWalletAmount();
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: textView1(
                              title:
                                  "Use Wallet Amount (Rs ${tempWalletAmount})",
                              textSize: 2.0,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: textField1(
                              hint: "Enter Voucher Code",
                              controller: voucherTextController,
                              //margin: EdgeInsets.only(top: 8.0),
                            ),
                            flex: 3,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppConstants.appColor.primaryLightColor3,
                                  AppConstants.appColor.primaryColor
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  apply();
                                },
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: AppConstants.appColor.whiteColor,
                                    fontSize: SizeConfig.textMultiplier * 2.0,
                                    //fontWeight: setFontWeight(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              deliveryDateTimeFormatter() == null
                                  ? "Pick Date and Time for delivery"
                                  : "Delivery Time: " +
                                      deliveryDateTimeFormatter()
                                          .replaceAll("T", " "),
                              style: TextStyle(
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 2.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //flex: 3,
                          ),
                          SizedBox(width: 16),
                          Container(
                            alignment: Alignment.topRight,
                            child: InkResponse(
                              onTap: () async {
                                final date =
                                    await DateTimePickerWidget.pickDate(
                                  context: context,
                                  initialDate: DateTime.now(),
                                );

                                final time =
                                    await DateTimePickerWidget.pickTime(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (date == null) return;
                                if (time == null) return;
                                setState(() {
                                  deliveryDate = date;
                                  deliveryTime = time;
                                });
                              },
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.deepPurpleAccent[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;

    return renderWithAppBar(
      appBarText: "Your Order",
      appBarHeight: appBarHeight,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
    );
  }
}
