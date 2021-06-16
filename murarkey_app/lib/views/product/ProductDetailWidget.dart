import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
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
  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState
    extends CustomStatefulWidgetState<ProductDetailWidget> {
  final ProductDetailViewModel viewModel = new ProductDetailViewModel();
  final List<HomepageBannerModel> bannerModelList = new List();

  _ProductDetailWidgetState() {
    bannerModelList.add(new HomepageBannerModel(
        imageUrl: "http://murarkey.surge.sh/img/products/rustic1.jpg"));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    buildView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Product Banner
          // ProductBannerWidget(
          //   imageUrl: ,
          // ),

          ImageSliderWidget(
            bannerModelList: bannerModelList,
            bannerHeight: 210,
          ),

          //Product Name and Address
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Product Category
                textView1(
                    title: "HAIR",
                    textAlign: TextAlign.start,
                    color: AppConstants.appColor.greyColor,
                    textSize: 1.8,
                    fontWeight: FontWeight.bold),

                //Product Name
                SizedBox(height: 2),
                textView1(
                    title: "Rustic Art Coconut Nectar Baby Shampoo 175gms",
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
                  body: "00012",
                ),

                //Product Sku
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Rs 300 ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.appColor.primaryLightColor,
                          fontSize: SizeConfig.textMultiplier * 2.4,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Rs 350",
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
                  title: "Add to Card",
                  viewModel: viewModel,
                ),

                //Product Description
                SizedBox(height: 24),
                ProductDescriptionWidget(
                  title: "Introduction",
                  body:
                      "Coconut nectar, amino proteins, multi vitamins and minerals; baby shampoo is fully loaded with the nourishment powerhouse with extremely mild fragrance ensuring a sound bath for the baby.\n\n\t\tAloe Vera and betain make sure that your baby’s scalp remains itch free and moisturized! Rustic art liquid shampoo is completely biodegradable.",
                ),
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
