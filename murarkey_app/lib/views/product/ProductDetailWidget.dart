import 'dart:convert';

import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/product/view_model/ProductDetailViewModel.dart';
import 'package:murarkey_app/views/product/widgets/ProductBannerWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductDescriptionWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductToCardWidget.dart';
import 'package:murarkey_app/views/product/widgets/ProductTypeWidget.dart';

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

  _ProductDetailWidgetState({
    @required this.productModel,
  });

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // Get home page banners list
    await _repository.productRequestApi
        .getProductDetail(
            url: ApiUrls.PRODUCT_DETAIL + productModel.id.toString())
        .then((value) => {
              productDetailModel = value,
              this.setState(() {}),
            });
  }

  String getTagToString(){
    if(productDetailModel != null) {
      if (productDetailModel.tags_array != null) {
        return productDetailModel.tags_array.join(", ");
      }
    }
    return "";
  }

  String getCategoryToString(){
    if(productDetailModel != null) {
      if (productDetailModel.sub_category_array != null) {
        return productDetailModel.sub_category_array.join(", ");
      }
    }
    return "";  }

  addToCartToServer() async {
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

    await _repository.productRequestApi
        .addToCard(url: ApiUrls.CART, params: params)
        .then((value) => {
              if (value != null)
                {
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

    await _repository.wishlistRequestApi
        .addToWishlist(url: ApiUrls.ADD_TO_WISHLIST, params: params)
        .then((value) => {
              if (value != null)
                {
                  Commons.toastMessage(context, value["message"]),
                },
              this.setState(() {}),
            });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            RichText(
              text: TextSpan(
                text: productDetailModel != null ? productDetailModel.brand_name["name"] : "",
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

            SizedBox(height: 2),

            //Product Name
            RichText(
              text: TextSpan(
                text: productDetailModel != null ? productDetailModel.name : "",
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
      return Container(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: RichText(
                text: TextSpan(
                  text: "Price: ",
                  style: TextStyle(
                      color: AppConstants.appColor.primaryDarkColor,
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                  text: productDetailModel != null
                      ? "Rs " +
                          productDetailModel.price_after_discount.toString()
                      : "Rs 0",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstants.appColor.buttonColor3,
                    fontSize: SizeConfig.textMultiplier * 2.4,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: " "),
                    TextSpan(
                        text: productDetailModel != null
                            ? "Rs " + productDetailModel.price.toString()
                            : "Rs 0",
                        style: TextStyle(
                          color: AppConstants.appColor.greyColor,
                          fontSize: SizeConfig.textMultiplier * 2.4,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 1.2,
                          decorationColor: AppConstants.appColor.redColor,
                        )),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
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
                SizedBox(height: 28),

                //Product Categories
                ProductTypeWidget(
                  title: "CATEGORY: ",
                  body: getCategoryToString(),
                ),

                //Product Categories
                SizedBox(height: 4),
                ProductTypeWidget(
                  title: "TAGS: ",
                  body: getTagToString(),
                ),

                //Product Sku
                SizedBox(height: 4),
                ProductTypeWidget(
                  title: "Sku: ",
                  body: productDetailModel != null
                      ? productDetailModel.sku.toString()
                      : "",
                ),

                //Product Sku
                SizedBox(height: 4),
                productPrice(),

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                categoryAndTags(),

                SizedBox(height: 32),
                ProductDescriptionWidget(
                    title: "Introduction",
                    body: productDetailModel != null
                        ? productDetailModel.details
                        : ""),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      );
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
