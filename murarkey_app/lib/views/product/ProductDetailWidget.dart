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

  addToCartToServer() async {
    //Add product
    Map<String, dynamic> params = new Map();
    params["product_id"] = productDetailModel.id.toString();
    params["qty"] = viewModel.count.toString();

    Map<String, dynamic> options = new Map();
    options["image"] = productDetailModel.images[0].imageUrl;

    params["options"] = options.toString(); //json.encode(options);

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

    buildView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Product Banner
          productDetailModel != null
              ? ImageSliderWidget(
                  bannerModelList: productDetailModel.images,
                  bannerHeight: 210,
                )
              : Container(),

          //Product Name and Address
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Product Category
                textView1(
                    title: productDetailModel != null
                        ? productDetailModel.category.name.toUpperCase()
                        : "",
                    textAlign: TextAlign.start,
                    color: AppConstants.appColor.greyColor,
                    textSize: 1.8,
                    fontWeight: FontWeight.bold),

                //Product Name
                SizedBox(height: 2),
                textView1(
                    title: productDetailModel != null
                        ? productDetailModel.name
                        : "",
                    textAlign: TextAlign.start,
                    color: AppConstants.appColor.blackColor,
                    textSize: 2.3,
                    fontWeight: FontWeight.bold),

                //Product Categories
                SizedBox(height: 16),
                ProductTypeWidget(
                  title: "CATEGORY: ",
                  body: "More Accessories, Wallets & Cases",
                ),

                //Product Categories
                SizedBox(height: 4),
                ProductTypeWidget(
                  title: "TAGS: ",
                  body: "Clothing, T-shirt, Woman",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: productDetailModel != null
                            ? productDetailModel.price_after_discount.toString()
                            : "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.appColor.primaryLightColor,
                          fontSize: SizeConfig.textMultiplier * 2.4,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: productDetailModel != null
                                  ? productDetailModel.price.toString()
                                  : "0",
                              style: TextStyle(
                                color: AppConstants.appColor.greyColor,
                                fontSize: SizeConfig.textMultiplier * 2.0,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 1.2,
                                decorationColor: AppConstants.appColor.redColor,
                              )),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),

                SizedBox(height: 24),
                ProductToCardWidget(
                  title: "Add to Cart",
                  viewModel: viewModel,
                  addToCard: () {
                    _addToCard();
                  },
                ),

                //Product Description
                SizedBox(height: 24),
                ProductDescriptionWidget(
                    title: "Introduction",
                    body: productDetailModel != null
                        ? productDetailModel.details
                        : ""),
              ],
            ),
          ),
        ],
      );
    }

    return renderWithAppBar(
        appBarText: "Product Details", childWidget: buildView());
  }
}
