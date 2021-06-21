import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
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
  bool isTheirContentData = false;
  double _imageHeight = 88.0;

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
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _imageHeight,
      );
    }

    Widget buildItems(ContentCartModel content, int index) {
      return Container(
        //height: double.infinity,
        padding:
            EdgeInsets.only(left: 8.0, top: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: loadImage(content.options[
                      "image"]), //"https://murarkey.surge.sh/img/products/rustic1.jpg"),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textView1(
                          title: content.name,
                          textAlign: TextAlign.start,
                          color: AppConstants.appColor.blackColor,
                          textSize: 1.6,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 2),
                      textView1(
                          title:
                              "Price: Rs. ${content.price.toString()} per item",
                          textAlign: TextAlign.start,
                          color: AppConstants.appColor.blackColor,
                          textSize: 1.6,
                          fontWeight: FontWeight.normal),
                      SizedBox(height: 2),
                      textView1(
                          title: "Item: ${content.qty.toString()}",
                          textAlign: TextAlign.start,
                          color: AppConstants.appColor.blackColor,
                          textSize: 1.6,
                          fontWeight: FontWeight.normal),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textView1(
                              title:
                                  "Total: Rs. ${content.subtotal.toString()}",
                              textAlign: TextAlign.right,
                              color: AppConstants.appColor.primaryLightColor,
                              textSize: 1.8,
                              fontWeight: FontWeight.bold),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget horizontalList2 = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartModel.getContent().length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: buildItems(cartModel.getContent()[index], index),
            ),
          );
        });

    alignBottom() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              textView1(
                  title: "Tax: Rs. " +
                      (isTheirContentData == true ? "${cartModel.tax}" : "0.0"),
                  textAlign: TextAlign.right,
                  color: AppConstants.appColor.primaryLightColor,
                  textSize: 2.0,
                  margin:
                      EdgeInsets.only(left: 16, right: 32, top: 32, bottom: 0),
                  fontWeight: FontWeight.bold),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              textView1(
                  title: "Total Price: Rs. " +
                      (isTheirContentData == true
                          ? "${cartModel.total}"
                          : "0.0"),
                  textAlign: TextAlign.right,
                  color: AppConstants.appColor.primaryLightColor,
                  textSize: 2.0,
                  margin:
                      EdgeInsets.only(left: 16, right: 32, top: 0, bottom: 0),
                  fontWeight: FontWeight.bold),
            ],
          ),
        ],
      );
    }

    buildView() {
      return Column(
        children: [
          //Shipping and Billing
          ShippingAndBillingWidget.get(),
          isTheirContentData == true ? horizontalList2 : Container(),
          alignBottom()
        ],
      );
    }

    return renderWithAppBar(appBarText: "Your Order", childWidget: buildView());
  }
}
