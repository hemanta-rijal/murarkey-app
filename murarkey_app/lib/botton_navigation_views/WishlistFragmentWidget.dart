import 'dart:io';

import 'package:murarkey_app/botton_navigation_views/view_model/CardViewModel.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/open_social_media/OpenFacebookApp.dart';
import 'package:url_launcher/url_launcher.dart';

//https://medium.com/flutter-community/build-a-chatbot-in-20-minutes-using-flutter-and-dialogflow-8e9af1014463
//https://stackoverflow.com/questions/55838430/flutter-open-facebook-link-in-facebook-app-android-ios

class WishlistFragmentWidget extends StatefulWidget {
  @override
  _WishlistFragmentWidgetState createState() => _WishlistFragmentWidgetState();
}

class _WishlistFragmentWidgetState
    extends CustomStatefulWidgetState<WishlistFragmentWidget> {
  Repository _repository = new Repository();
  CardViewModel viewModel = new CardViewModel();
  CartModel cartModel = new CartModel();
  bool isTheirContentData = false;
  double _imageHeight = 88.0;

  _WishlistFragmentWidgetState() {
    loadData();
  }

  loadData() async {
    await _repository.wishlistRequestApi
        .getAllWishList(url: ApiUrls.GET_ALL_WISHLIST)
        .then((value) => {
      if (value != null)
        {
          cartModel = value,
          loadContent(),
          this.setState(() {}),
        }
    });
  }

  loadContent() {
    if (cartModel != null) {
      print("CartFrag");
      if (cartModel.getContent().length > 0) {
        viewModel.loadProductTextLists(cartModel.getContent());
        if (cartModel.getContent() != null) {
          isTheirContentData = true;
        } else {
          isTheirContentData = false;
        }
      } else {
        isTheirContentData = false;
      }
    }
  }

  pushItemData(ContentCartModel content, String noOfItems) async {
    print("noOfItem= " + noOfItems);

    Map<String, dynamic> params = new Map();
    params["qty"] = noOfItems;

    await _repository.productRequestApi
        .updateToCard(
      url: ApiUrls.CART + "/" + content.rowId,
      params: params,
    )
        .then((value) => {
      if (value != null)
        {
          //if (value["status"] == true)
          // {
          loadData(),
          //  }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget loadImage(String imgUrl) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        height: _imageHeight,
      );
    }

//https://stackoverflow.com/questions/52645944/flutter-expanded-vs-flexible
    Widget addToCardWidget(ContentCartModel content, int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: InkResponse(
                child: svgImageAssert2(
                    imgUrl: "images/maths/ic_sub.svg", size: 24),
                onTap: () {
                  setState(() {
                    viewModel.productTextList[index].text = viewModel
                        .subtract(viewModel.productTextList[index].text)
                        .toString();

                    pushItemData(
                        content, viewModel.productTextList[index].text);
                  });
                },
              )),
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: textFieldDisableKeyboard(
                fontSize: SizeConfig.textMultiplier * 1.6,
                height: 24,
                controller: viewModel.productTextList[index],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkResponse(
              child:
              svgImageAssert2(imgUrl: "images/maths/ic_add.svg", size: 24),
              onTap: () {
                setState(() {
                  viewModel.productTextList[index].text = viewModel
                      .add(viewModel.productTextList[index].text)
                      .toString();

                  pushItemData(content, viewModel.productTextList[index].text);
                });
              },
            ),
          ),
        ],
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
                      SizedBox(height: 8),
                      // addToCardWidget(content, index),
                      // SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     textView1(
                      //         title:
                      //         "Total: Rs. ${content.subtotal.toString()}",
                      //         textAlign: TextAlign.right,
                      //         color: AppConstants.appColor.primaryLightColor,
                      //         textSize: 1.8,
                      //         fontWeight: FontWeight.bold),
                      //   ],
                      // )
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     textView1(
          //         title: "Tax: Rs. " +
          //             (isTheirContentData == true ? "${cartModel.tax}" : "0.0"),
          //         textAlign: TextAlign.right,
          //         color: AppConstants.appColor.primaryLightColor,
          //         textSize: 2.0,
          //         margin:
          //         EdgeInsets.only(left: 16, right: 32, top: 32, bottom: 0),
          //         fontWeight: FontWeight.bold),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     textView1(
          //         title: "Total Price: Rs. " +
          //             (isTheirContentData == true
          //                 ? "${cartModel.total}"
          //                 : "0.0"),
          //         textAlign: TextAlign.right,
          //         color: AppConstants.appColor.primaryLightColor,
          //         textSize: 2.0,
          //         margin:
          //         EdgeInsets.only(left: 16, right: 32, top: 0, bottom: 0),
          //         fontWeight: FontWeight.bold),
          //   ],
          // ),
          FlatStatefulButton(
            text: "PROCEED TO CHECK OUT",
            fontSize: SizeConfig.textMultiplier * 1.8,
            textColor: AppConstants.appColor.accentColor,
            padding: EdgeInsets.all(screenSize.width * .02),
            backgroundColor: AppConstants.appColor.primaryColor,
            buttonHeight: 40,
            margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
            //buttonWidth: 100,
            onPressedCallback: () {
              if (isTheirContentData == true && cartModel != null) {
                // NavigateRoute.pushNamed(
                //     context, NavigateRoute.ORDER_PLACED_PRODUCTS);
              } else {
                Commons.toastMessage(context, "Their is no order to shop");
              }
            },
          )
        ],
      );
    }

    builder() {
      return isTheirContentData == true
          ? Column(
        children: [horizontalList2, alignBottom()],
      )
          : Container(
        margin: EdgeInsets.only(top: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/cart/ic_empty_cart.png",
              height: 300,
              width: 300,
            ),
          ],
        ),
      );
    }

    return renderWithAppBar(
      appBarText: "Wishlist",
      showBackbutton: false,
      appBarTextAlignment: MainAxisAlignment.center,
      childWidget: builder(),
      //floatingActionButton: FBFloatingButton().fab(),
    );
  }
}
