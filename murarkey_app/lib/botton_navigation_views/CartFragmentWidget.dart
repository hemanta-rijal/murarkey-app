import 'package:murarkey_app/botton_navigation_views/view_model/CardViewModel.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/custom_views/fb_float_button/FBFloatingButton.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

class CartFragmentWidget extends StatefulWidget {
  @override
  _CartFragmentWidgetState createState() => _CartFragmentWidgetState();
}

class _CartFragmentWidgetState
    extends CustomStatefulWidgetState<CartFragmentWidget> {
  Repository _repository = new Repository();
  CardViewModel viewModel = new CardViewModel();
  CartModel cartModel = new CartModel();
  bool isTheirContentData = false;
  Size size;
  var _cardSize = 100.0;
  var appBarHeight = 50.0;

  _CartFragmentWidgetState() {
    loadData();
  }

  loadData() async {
    await _repository.productRequestApi
        .getCartList(url: ApiUrls.CART)
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

    Widget addToCardWidget2(ContentCartModel content, int index) {
      return Container(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                // decoration: BoxDecoration(
                //   shape: BoxShape.rectangle,
                //   border: Border.all(
                //       width: 1, color: AppConstants.appColor.greyColor),
                //   borderRadius: BorderRadius.all(Radius.circular(2)),
                // ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkResponse(
                          child: svgImageAssert2(
                            imgUrl: "images/maths/ic_sub_2.svg",
                            size: 16,
                            color: AppConstants.appColor.blackColor,
                          ),
                          onTap: () {
                            setState(() {
                              viewModel.productTextList[index].text = viewModel
                                  .subtract(
                                      viewModel.productTextList[index].text)
                                  .toString();

                              pushItemData(content,
                                  viewModel.productTextList[index].text);
                            });
                          },
                        )),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 4.0, right: 4.0),
                        color: Colors.grey[200],
                        child: textFieldDisableKeyboard(
                          textAlign: TextAlign.center,
                          borderColor: AppConstants.appColor.whiteColor,
                          height: 30,
                          controller: viewModel.productTextList[index],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkResponse(
                        child: svgImageAssert2(
                          imgUrl: "images/maths/ic_add_2.svg",
                          size: 16,
                          color: AppConstants.appColor.blackColor,
                        ),
                        onTap: () {
                          setState(() {
                            viewModel.productTextList[index].text = viewModel
                                .add(viewModel.productTextList[index].text)
                                .toString();

                            pushItemData(
                                content, viewModel.productTextList[index].text);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                            title: "NRP ${content.price.toString()} per item",
                            textAlign: TextAlign.start,
                            color: AppConstants.appColor.greyColor,
                            textSize: 2.0,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: textView1(
                                  title: "NRP ${content.subtotal.toString()}",
                                  textAlign: TextAlign.left,
                                  color:
                                      AppConstants.appColor.primaryLightColor,
                                  textSize: 2.3,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: addToCardWidget2(content, index),
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
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textView1(
                              title: "Tax: NRP. " +
                                  (isTheirContentData == true
                                      ? "${cartModel.tax}"
                                      : "0.0"),
                              color: AppConstants.appColor.primaryLightColor,
                              textSize: 2.0,
                              fontWeight: FontWeight.bold),
                          RichText(
                            text: TextSpan(
                              text: "Total: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.textMultiplier * 2.3,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "NRP. " +
                                      (isTheirContentData == true
                                          ? "${cartModel.total}"
                                          : "0.0"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppConstants.appColor.primaryLightColor,
                                    fontSize: SizeConfig.textMultiplier * 2.5,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    )),
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
                            NavigateRoute.pushNamed(
                                context, NavigateRoute.ORDER_PLACED_PRODUCTS);
                          } else {
                            Commons.toastMessage(context, "Their is no order to shop");
                          }
                        },
                        child: Text(
                          "Check out",
                          style: TextStyle(
                            color: AppConstants.appColor.whiteColor,
                            fontSize: SizeConfig.textMultiplier * 2.0,
                            //fontWeight: setFontWeight(),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      );
    }

    Widget floatingWidget() {
      return isTheirContentData ? alignBottom() : Container();
    }

    builder() {
      return isTheirContentData == true
          ? Column(
              children: [
                horizontalList2,
                SizedBox(
                  height: _cardSize - 16,
                )
              ],
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
      appBarText: "Shopping List",
      showBackbutton: false,
      appBarTextAlignment: MainAxisAlignment.center,
      childWidget: builder(),
      appBarHeight: appBarHeight,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      floatingWidget: floatingWidget(),
      //floatingActionButton: FBFloatingButton().fab(),
    );
  }
}
