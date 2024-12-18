import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:murarkey_app/botton_navigation_views/view_model/CardViewModel.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/UnauthorizedUserWidget.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/loader/LoaderDialog.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
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
  Size size;
  var _cardSize = 100.0;
  var appBarHeight = 50.0;
  UserModel userModel = GlobalData.userModel;
  bool loginRequired;
  bool loading = false;
  bool hasNetworkConnectivity = true;

  _WishlistFragmentWidgetState() {
    EasyLoadingView.show(message: 'Loading...');
    loadData();
  }

  @override
  void didChangeDependencies() {
    // if (mounted) {
    //   userModel = GlobalData.userModel;
    //   if (userModel.name == null) {
    //     Future.delayed(const Duration(milliseconds: 500), () {
    //       setState(() {
    //         Commons.toastMessage(
    //             context, "Please Login to seen your wishlist order placed.");
    //         //NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
    //         setState(() {
    //           loginRequired = true;
    //         });
    //       });
    //     });
    //   } else {
    //     setState(() {
    //       loginRequired = false;
    //     });
    //   }
    // }
    super.didChangeDependencies();
  }

  loadData() async {
    hasNetworkConnectivity = await Commons.checkNetworkConnectivity();
    if (!hasNetworkConnectivity) {
      loading = true;
      EasyLoadingView.dismiss();
      setState(() {});
      return;
    }

    await _repository.wishlistRequestApi
        .getAllWishList(url: ApiUrls.GET_ALL_WISHLIST)
        .then((value) => {
              if (value != null)
                {
                  cartModel = value,
                  loadContent(),
                  loading = true,
                  this.setState(() {}),
                },
              EasyLoadingView.dismiss(),
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

    EasyLoadingView.show(message: 'Loading...');
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

  addToCartToServer(ContentCartModel model) async {
    var check = await Commons.checkNetworkConnectivity();
    if (!check) {
      EasyLoading.show(
        status: "",
        indicator: Connectivity2Widget(
          retry: () {
            addToCartToServer(model);
          },
          cancel: () {
            EasyLoading.dismiss();
          },
        ),
        maskType: EasyLoadingMaskType.custom,
      );
      return;
    } else {
      //Add product
      Map<String, dynamic> params = new Map();
      params["product_id"] = model.id.toString();
      params["qty"] = 1.toString();

      params["type"] = "product";
      params["options"] = {
        "image": model.options["image"],
        "product_type": "product"
      };

      print(params);

      EasyLoadingView.show(message: 'Loading...');
      await _repository.productRequestApi
          .addToCard(url: ApiUrls.CART, params: params)
          .then((value) async {
        if (value != null) {
          Commons.toastMessage(context, value["message"]);
          await loadData();
        }
        this.setState(() {});
      });
    }
  }

  proceedAllToCard() async {
    var check = await Commons.checkNetworkConnectivity();
    if (!check) {
      EasyLoading.show(
        status: "",
        indicator: Connectivity2Widget(
          retry: () {
            proceedAllToCard();
          },
          cancel: () {
            EasyLoading.dismiss();
          },
        ),
        maskType: EasyLoadingMaskType.custom,
      );
      return;
    } else {
      EasyLoadingView.show(message: 'Loading...');
      await _repository.productRequestApi
          .proceedAllToCard(url: ApiUrls.PROCEED_ALL_TO_CART_WISHLIST)
          .then((value) async {
        if (value != null) {
          Commons.toastMessage(context, value["message"]);
          await loadData();
        }
        this.setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);

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
                            title: "Rs ${content.price.toString()} per item",
                            textAlign: TextAlign.start,
                            color: AppConstants.appColor.greyColor,
                            textSize: 2.0,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: FlatButton3(
                                text: "ADD TO CART",
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                textColor: AppConstants.appColor.redColor,
                                padding: EdgeInsets.only(left: 16, right: 16),
                                backgroundColor:
                                    AppConstants.appColor.whiteColor,
                                buttonHeight: 30,
                                //buttonWidth: double.infinity,
                                buttonCurve: 1.2,
                                fontWeight: FontWeight.w800,
                                boderColor: AppConstants.appColor.primaryColor,
                                //buttonWidth: 100,
                                onPressedCallback: () {
                                  addToCartToServer(content);
                                },
                              ),
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
        padding: const EdgeInsets.all(8),
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

    alignBottom() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppConstants.appColor.primaryLightColor3,
                        AppConstants.appColor.primaryColor
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (isTheirContentData == true && cartModel != null) {
                          proceedAllToCard();
                        } else {
                          Commons.toastMessage(
                              context, "Their is no order to shop");
                        }
                      },
                      child: Text(
                        "Proceed All Products To Cart",
                        style: TextStyle(
                          color: AppConstants.appColor.whiteColor,
                          fontSize: SizeConfig.textMultiplier * 2.0,
                          //fontWeight: setFontWeight(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    builder() {
      // if (loginRequired == null) {
      //   return Container();
      // } else if (loginRequired) {
      //   return UnauthorizedUserWidget();
      // }

      userModel = GlobalData.userModel;
      if (userModel.name == null) {
        loginRequired = true;
      } else {
        loginRequired = false;
      }

      if (loginRequired == null || !loading) {
        return Container();
      } else if (!hasNetworkConnectivity) {
        return Container(
          margin: EdgeInsets.only(top: 180),
          child: ConnectivityWidget(
            retry: () {
              hasNetworkConnectivity = true;
              loginRequired = null;
              loading = false;
              setState(() {});
              EasyLoadingView.show(message: 'Loading...');
              Future.delayed(Duration(seconds: 2), () {
                loadData();
              });
            },
          ),
        );
      } else if (hasNetworkConnectivity && loginRequired && loading) {
        return UnauthorizedUserWidget();
      }

      return isTheirContentData == true
          ? Column(
              children: [
                horizontalList2,
                SizedBox(
                  height: _cardSize - 16,
                ),
              ],
            )
          : loading
              ? Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/cart/ic_empty_cart_4.png",
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "List is Empty",
                            style: TextStyle(
                              color: AppConstants.appColor.greyColor,
                              fontSize: SizeConfig.textMultiplier * 3.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container();
    }

    Widget floatingWidget() {
      return isTheirContentData ? alignBottom() : Container();
    }

    return renderWithAppBar(
      appBarText: "Wishlist",
      showBackbutton: false,
      appBarTextAlignment: MainAxisAlignment.center,
      appBarHeight: appBarHeight,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: builder(),
      floatingWidget: floatingWidget(),
    );
  }
}
