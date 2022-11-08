import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/custom_views/review/ReviewWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/repository/models/review/ReviewModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/SlugManager.dart';
import 'package:murarkey_app/views/product/view_model/ProductDetailViewModel.dart';
import 'package:murarkey_app/views/product/widgets/ProductBannerWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductDescriptionWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductToCardWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductTypeWidget.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */
class ProductDetailWidget extends StatefulWidget {
  final ProductDetailModel productModel;

  ProductDetailWidget({
    Key key,
    @required this.productModel,
  }) : super(key: key);

  @override
  _ProductDetailWidgetState createState() =>
      _ProductDetailWidgetState(productModel: productModel);
}

class _ProductDetailWidgetState
    extends CustomStatefulWidgetState<ProductDetailWidget> {
  Repository _repository = new Repository();
  final ProductDetailModel productModel;
  final ProductDetailViewModel viewModel = new ProductDetailViewModel();
  List<HomepageBannerModel> bannerModelList;
  ProductDetailModel productDetailModel;
  bool loading = false;
  bool hasNetworkConnectivity = true;

  _ProductDetailWidgetState({
    @required this.productModel,
  });

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    hasNetworkConnectivity = await Commons.checkNetworkConnectivity();
    if (!hasNetworkConnectivity) {
      loading = true;
      EasyLoadingView.dismiss();
      setState(() {});
      return;
    }

    // Get home page banners list
    EasyLoadingView.show(message: 'Loading...');
    await _repository.productRequestApi
        .getProductDetail(
          url: ApiUrls.PRODUCT_DETAIL + productModel.id.toString(),
          //url: ApiUrls.PRODUCT_DETAIL + "1250",
        )
        .then((value) => {
              productDetailModel = value,
              EasyLoadingView.dismiss(),
              this.setState(() {}),
            });
  }

  List<dynamic> getTagToString() {
    if (productDetailModel != null) {
      if (productDetailModel.tags_array != null) {
        //return productDetailModel.tags_array.join(", ");
        return productDetailModel.tags_array;
      }
    }
    return [];
  }

  String getCategoryToString() {
    if (productDetailModel != null) {
      if (productDetailModel.sub_category_array != null) {
        return productDetailModel.sub_category_array.join(", ");
      }
    }
    return "";
  }

  addToCartToServer() async {
    var check = await Commons.checkNetworkConnectivity();
    if (!check) {
      EasyLoading.show(
        status: "",
        indicator: Connectivity2Widget(
          retry: () {
            addToCartToServer() ;
          },
          cancel: (){
            EasyLoading.dismiss();
          },
        ),
        maskType: EasyLoadingMaskType.custom
      );
      return;
    }
    //Add product
    Map<String, dynamic> params = new Map();
    params["product_id"] = productDetailModel.id.toString();
    params["qty"] = viewModel.count.toString();

    Map<String, dynamic> options = new Map();
    options["image"] = productDetailModel.images[0].imageUrl;

    //params["options"] = //json.encode(options);
    // options.toString(); //
    params["type"] = "product";
    params["options"] = {
      "image": productDetailModel.images[0].imageUrl,
      "product_type": "product"
    };

    print(params);

    EasyLoadingView.show(message: 'Adding to cart...');
    await _repository.productRequestApi
        .addToCard(url: ApiUrls.CART, params: params)
        .then((value) => {
              if (value != null)
                {
                  EasyLoadingView.dismiss(),
                  Commons.toastMessage(context, value["message"]),
                },
              this.setState(() {}),
            });
  }

  _saveToWishList() async {
    //Add product
    Map<String, dynamic> params = new Map();
    params["product_id"] = productDetailModel.id.toString();
    params["qty"] = viewModel.count.toString();

    Map<String, dynamic> options = new Map();
    options["image"] = productDetailModel.images[0].imageUrl;

    //params["options"] = //json.encode(options); //options.toString(); //
    params["type"] = "product";
    params["options"] = {
      "image": productDetailModel.images[0].imageUrl,
      "product_type": "product"
    };

    EasyLoadingView.show(message: 'Adding to Wishlist...');
    await _repository.wishlistRequestApi
        .addToWishlist(url: ApiUrls.ADD_TO_WISHLIST, params: params)
        .then((value) => {
              if (value != null)
                {
                  EasyLoadingView.dismiss(),
                  Commons.toastMessage(context, value["message"]),
                },
              this.setState(() {}),
            });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget tagWidget() {
      if (productDetailModel != null) {
        if (productDetailModel.tags_array != null) {
          return ProductTypeWidget(
            title: "TAGS: ",
            body: "",
            bodyList: getTagToString(),
            onTabSlugItem: (String slug) {},
          );
        }
      }
      return Container();
    }

    Widget brandWidget() {
      if (productDetailModel != null) {
        if (productDetailModel.brand != null) {
          return ProductTypeWidget(
            title: "BRAND: ",
            body: "",
            bodyList: ["${productDetailModel.brand.name}"],
            onTabSlugItem: (String slug) {
              NavigateRoute.pop(context);
              NavigateRoute.pop(context);

              print(
                  "productDetailModel.brand-------------> ${productDetailModel.brand}");

              Map<String, dynamic> arguments = new Map();
              arguments["categoryModelList"] = GlobalData.categoryModelList;
              arguments["brandModelList"] = GlobalData.brandModelList;
              arguments["slugType"] = SearchWidget.TYPE_BRAND_SLUG;
              arguments["slug"] = productDetailModel.brand.slug;
              arguments["brandModel"] = productDetailModel.brand;

              NavigateRoute.pushNamedWithArguments(
                context,
                NavigateRoute.SEARCH,
                arguments,
              );
            },
          );
        }
      }
      return Container();
    }

    Widget categoryWidget() {
      if (productDetailModel != null) {
        if (productDetailModel.category != null) {
          return Column(
            children: [
              SizedBox(height: 4),
              ProductTypeWidget(
                title: "CATEGORY: ",
                body: "",
                bodyList: ["${productDetailModel.category.name}"],
                onTabSlugItem: (String slug) {
                  NavigateRoute.pop(context);
                  NavigateRoute.pop(context);

                  print(
                      "productDetailModel.category-------------> ${productDetailModel.category.toJson()}");

                  Map<String, dynamic> arguments = new Map();
                  arguments["categoryModelList"] = GlobalData.categoryModelList;
                  arguments["brandModelList"] = GlobalData.brandModelList;
                  arguments["slugType"] = SearchWidget.TYPE_CATEGORY_SLUG;
                  arguments["slug"] = productDetailModel.category.slug;
                  arguments["categoryModel"] = productDetailModel.category;

                  // arguments["categoryModelList"] = categoryModelList;
                  // arguments["brandModelList"] = brandModelList;
                  // arguments["slugType"] = SearchWidget.TYPE_CATEGORY_SLUG;
                  // arguments["slug"] = categoryModel.slug;
                  // arguments["categoryModel"] = categoryModel;

                  NavigateRoute.pushNamedWithArguments(
                    context,
                    NavigateRoute.SEARCH,
                    arguments,
                  );
                },
              ),
            ],
          );
        }
      }
      return Container();
    }

    Widget attributeWidget() {
      if (productDetailModel != null) {
        if (productDetailModel.attribute != null &&
            productDetailModel.attribute.length > 0) {
          List<Widget> productTypeWidget = [];

          productDetailModel.attribute.forEach((key, value) {
            productTypeWidget.add(
              SizedBox(height: 4),
            );
            productTypeWidget.add(
              ProductTypeWidget(
                title: "${key.toUpperCase()}:",
                body: "",
                bodyList: value,
                onTabSlugItem: (String slug) {
                  NavigateRoute.pop(context);
                  NavigateRoute.pop(context);

                  Map<String, dynamic> arguments = new Map();
                  arguments["categoryModelList"] = GlobalData.categoryModelList;
                  arguments["brandModelList"] = GlobalData.brandModelList;
                  arguments["attribute"] = "${slug}";

                  NavigateRoute.pushNamedWithArguments(
                    context,
                    NavigateRoute.SEARCH,
                    arguments,
                  );
                },
              ),
            );
          });

          return Column(
            children: productTypeWidget,
          );
        }
      }
      return Container();
    }

    Widget skinVarientWidget({
      String title,
      String varient,
    }) {
      if (productDetailModel != null) {
        if (productDetailModel.getKeyTag(varient) != null &&
            productDetailModel.getKeyTag(varient).length > 0) {
          return Column(
            children: [
              SizedBox(height: 4),
              ProductTypeWidget(
                title: "${title}",
                body: "",
                bodyList: productDetailModel.getKeyTag(varient),
                onTabSlugItem: (String slug) {
                  NavigateRoute.pop(context);
                  NavigateRoute.pop(context);

                  Map<String, dynamic> skinVarientModelValue = {
                    "${varient}": "${slug}",
                  };

                  Map<String, dynamic> arguments = new Map();
                  arguments["categoryModelList"] = GlobalData.categoryModelList;
                  arguments["brandModelList"] = GlobalData.brandModelList;
                  arguments["skinVarientModelMap"] = skinVarientModelValue;

                  NavigateRoute.pushNamedWithArguments(
                    context,
                    NavigateRoute.SEARCH,
                    arguments,
                  );
                },
              ),
            ],
          );
        }
      }
      return Container();
    }

    _addToCard() {
      if (viewModel.count > 0) {
        addToCartToServer();
      } else {
        Commons.toastMessage(context,
            "Please no. of product should be greater than 1 to add to cart.");
      }
    }

    Widget divider() {
      return Container(
        width: double.infinity,
        height: 1,
        color: Colors.black26,
      );
    }

    Widget productName() {
      return Container(
        margin: EdgeInsets.only(top: 4, bottom: 8, left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Product Category
            InkWell(
              onTap: () {
                NavigateRoute.pop(context);
                NavigateRoute.pop(context);

                print(
                    "productDetailModel.brand-------------> ${productDetailModel.brand}");

                Map<String, dynamic> arguments = new Map();
                arguments["categoryModelList"] = GlobalData.categoryModelList;
                arguments["brandModelList"] = GlobalData.brandModelList;
                arguments["slugType"] = SearchWidget.TYPE_BRAND_SLUG;
                arguments["slug"] = productDetailModel.brand.slug;
                arguments["brandModel"] = productDetailModel.brand;

                NavigateRoute.pushNamedWithArguments(
                  context,
                  NavigateRoute.SEARCH,
                  arguments,
                );
              },
              child: RichText(
                text: TextSpan(
                  text: productDetailModel != null &&
                          productDetailModel.brand != null
                      ? "${productDetailModel.brand.name}"
                      : "",
                  // productDetailModel != null
                  //     ? productDetailModel.category.name.toUpperCase()
                  //     : "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppConstants.appColor.blackColor,
                    fontSize: SizeConfig.textMultiplier * 2.8,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(height: 2),

            //Product Name
            RichText(
              text: TextSpan(
                text: productDetailModel != null
                    ? "${productDetailModel.name}"
                    : "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.appColor.buttonColor3,
                  fontSize: SizeConfig.textMultiplier * 2.6,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Widget productPrice() {
      if (productDetailModel == null) {
        return Container();
      } else if (productDetailModel.price_after_discount == null) {
        return Container();
      }

      return Container(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   flex: 1,
            //   child: RichText(
            //     text: TextSpan(
            //       text: "Price: ",
            //       style: TextStyle(
            //           color: AppConstants.appColor.primaryDarkColor,
            //           fontSize: SizeConfig.textMultiplier * 2.0,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     textAlign: TextAlign.justify,
            //   ),
            // ),
            Expanded(
              flex: 1,
              child: RichText(
                text: TextSpan(
                  text: productDetailModel != null ? "Rs.  " : "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.appColor.blackColor,
                    fontSize: SizeConfig.textMultiplier * 2.4,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: productDetailModel != null
                          ? productDetailModel.price_after_discount.toString()
                          : "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appColor.blackColor,
                        fontSize: SizeConfig.textMultiplier * 3.5,
                      ),
                    ),
                    TextSpan(text: "\t\t\t\t"),
                    productDetailModel.price_after_discount !=
                            productDetailModel.price
                        ? TextSpan(
                            text: productDetailModel != null
                                ? "Rs. " + productDetailModel.price.toString()
                                : "Rs. 0",
                            style: TextStyle(
                              color: AppConstants.appColor.greyColor,
                              fontSize: SizeConfig.textMultiplier * 2.4,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 1.2,
                              decorationColor: AppConstants.appColor.greyColor,
                            ),
                          )
                        : TextSpan(text: ""),
                    productDetailModel.price_after_discount !=
                            productDetailModel.price
                        ? TextSpan(
                            text: productDetailModel != null &&
                                    productDetailModel.discount_rate != null
                                ? "  -${productDetailModel.discount_rate.toString()}%"
                                : "",
                            style: TextStyle(
                              color: AppConstants.appColor.blackColor,
                              fontSize: SizeConfig.textMultiplier * 2.4,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        : TextSpan(text: ""),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
    }

    Widget reviews() {
      if (productDetailModel == null) {
        return Container();
      }
      // else if (productDetailModel.reviews == null) {
      //   return Container();
      // }
      // else if (productDetailModel.reviews.length < 1) {
      //   return Container();
      // }

      print("reviews---------> ${productDetailModel.reviews}");
      return ReviewWidget(
        reviewable: productDetailModel.reviewable,
        model: productDetailModel.reviews,
        averageRate: productDetailModel.average_review,
        callback: () {},
      );
    }

    Widget categoryAndTags() {
      return Container(
        width: double.infinity,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productName(),

                SizedBox(height: 12),
                divider(),
                SizedBox(height: 20),

                productPrice(),
                SizedBox(height: 20),

                //Product Brand
                brandWidget(),

                //Product Categories
                categoryWidget(),

                skinVarientWidget(
                  title: "SKIN TYPE: ",
                  varient: "skin_type",
                ),

                skinVarientWidget(
                  title: "SKIN CONCERN: ",
                  varient: "skin_concern",
                ),

                skinVarientWidget(
                  title: "PRODUCT TYPE: ",
                  varient: "product_type",
                ),

                attributeWidget(),

                //Product Categories
                SizedBox(height: 4),
                tagWidget(),

                //Product Sku
                SizedBox(height: 4),
                ProductTypeWidget(
                  title: "Sku: ",
                  body: productDetailModel != null
                      ? productDetailModel.sku.toString()
                      : "",
                  onTabSlugItem: (String slug) {},
                ),

                //Product Sku
                // SizedBox(height: 4),
                // productPrice(),

                SizedBox(height: 24),

                divider(),

                SizedBox(height: 24),
                ProductToCardWidget(
                  title: "Add to Cart",
                  viewModel: viewModel,
                  price: productDetailModel != null
                      ? productDetailModel.price_after_discount
                      : 0,
                  addToCard: () {
                    _addToCard();
                  },
                  saveToWishlist: () {
                    _saveToWishList();
                  },
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }

    buildView() {
      if (!hasNetworkConnectivity) {
        //show dialog here
        print("viewModel.hasNetworkConnectivity===> ${hasNetworkConnectivity}");

        EasyLoading.show(
          status: "",
          indicator: Connectivity2Widget(
            retry: () {
              loadData();
              EasyLoading.dismiss();
            },
            cancel: (){
              EasyLoading.dismiss();
            },
          ),
        );
      }

      return productDetailModel != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                //Product Banner
                productDetailModel != null
                    ? Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 8),
                        child: ImageSliderWidget(
                          bannerModelList: productDetailModel.images,
                          bannerHeight: 200,
                          imageFit: BoxFit.contain,
                          backgroundColor: AppConstants.appColor.whiteColor,
                          //bannerWidth: 200,
                        ),
                      )
                    : Container(),

                //Product Name and Address
                Container(
                  margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryAndTags(),
                      SizedBox(height: 8),
                      ProductDescriptionWidget(
                          title: "Introduction",
                          body: productDetailModel != null
                              ? productDetailModel.details
                              : ""),
                      //SizedBox(height: 16),
                    ],
                  ),
                ),

                Container(
                  margin:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
                  width: double.infinity,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: reviews(),
                  ),
                ),
              ],
            )
          : Container();
    }

    return renderWithAppBar(
      appBarText: "Product Details",
      showBackbutton: true,
      appBarTextAlignment: MainAxisAlignment.start,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
    );
  }
}
