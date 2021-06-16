import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/product/view_model/ProductDetailViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductToCardWidget extends StatefulWidget {
  final String title;
  final ProductDetailViewModel viewModel;

  ProductToCardWidget({
    Key key,
    @required this.title,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ProductToCardWidgetState createState() => _ProductToCardWidgetState();
}

class _ProductToCardWidgetState extends State<ProductToCardWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

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
              //Product Title
              textView1(
                  title: widget.title,
                  textAlign: TextAlign.start,
                  color: AppConstants.appColor.blackColor,
                  textSize: 2.2,
                  fontWeight: FontWeight.bold),

              //Calculator
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: svgImageAssert2(
                        imgUrl: "images/maths/ic_sub.svg", size: 35),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: textFieldDisableKeyboard(
                        controller: widget.viewModel.formAddToCardItem,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: svgImageAssert2(
                        imgUrl: "images/maths/ic_add.svg", size: 35),
                  ),

                  // ADD
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 16.0),
                      child: FlatStatefulButton(
                        text: "ADD",
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        textColor: AppConstants.appColor.whiteColor,
                        padding: EdgeInsets.all(screenSize.width * .02),
                        backgroundColor: AppConstants.appColor.buttonColor,
                        buttonHeight: 35,
                        buttonCurve: 2.0,
                        //buttonWidth: 100,
                        onPressedCallback: () {},
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              FlatStatefulButton2(
                text: "Save To Wishlist",
                fontSize: SizeConfig.textMultiplier * 1.8,
                textColor: AppConstants.appColor.redColor,
                padding: EdgeInsets.all(screenSize.width * .02),
                backgroundColor: AppConstants.appColor.whiteColor,
                buttonHeight: 35,
                buttonCurve: 1.2,
                fontWeight: FontWeight.w800,
                boderColor: AppConstants.appColor.redColor,
                //buttonWidth: 100,
                onPressedCallback: () {},
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       //width: double.infinity,
              //       child: FlatStatefulButton(
              //         text: "Save To WishList",
              //         fontSize: SizeConfig.textMultiplier * 1.8,
              //         textColor: AppConstants.appColor.accentColor,
              //         padding: EdgeInsets.all(screenSize.width * .02),
              //         backgroundColor: AppConstants.appColor.buttonColor,
              //         buttonHeight: 35,
              //         //buttonWidth: 100,
              //         onPressedCallback: () {},
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
