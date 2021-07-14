import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/product/view_model/ProductDetailViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/15/2021.
 */

class ProductToCardWidget extends StatefulWidget {
  final String title;
  final ProductDetailViewModel viewModel;
  final int price;
  final Function() addToCard;
  final Function() saveToWishlist;

  ProductToCardWidget({
    Key key,
    @required this.title,
    @required this.viewModel,
    @required this.price,
    this.addToCard,
    this.saveToWishlist,
  }) : super(key: key);

  @override
  _ProductToCardWidgetState createState() => _ProductToCardWidgetState();
}

class _ProductToCardWidgetState extends State<ProductToCardWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    Widget totalPriceView() {
      return RichText(
        text: TextSpan(
          text: "Total: ",
          style: TextStyle(
              color: AppConstants.appColor.primaryDarkColor,
              fontSize: SizeConfig.textMultiplier * 1.7,
              fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: "Rs ${widget.viewModel.count * widget.price}",
                style: TextStyle(
                  color: AppConstants.appColor.textColor3,
                  fontSize: SizeConfig.textMultiplier * 1.7,
                )),
          ],
        ),
        textAlign: TextAlign.right,
      );
    }

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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: //Product Title
                        textView1(
                            title: widget.title,
                            textAlign: TextAlign.start,
                            color: AppConstants.appColor.blackColor,
                            textSize: 2.2,
                            fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: totalPriceView(),
                  )
                ],
              ),

              //Calculator
              SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              width: 2, color: AppConstants.appColor.greyColor),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: InkResponse(
                                  child: svgImageAssert2(
                                    imgUrl: "images/maths/ic_sub_2.svg",
                                    size: 16,
                                    color: AppConstants.appColor.greyColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.viewModel.formAddToCardItem.text =
                                          widget.viewModel
                                              .subtract()
                                              .toString();
                                    });
                                  },
                                )),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 4.0, right: 4.0),
                                child: textFieldDisableKeyboard(
                                  textAlign: TextAlign.center,
                                  borderColor: AppConstants.appColor.whiteColor,
                                  height: 30,
                                  controller:
                                      widget.viewModel.formAddToCardItem,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkResponse(
                                child: svgImageAssert2(
                                  imgUrl: "images/maths/ic_add_2.svg",
                                  size: 16,
                                  color: AppConstants.appColor.greyColor,
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.viewModel.formAddToCardItem.text =
                                        widget.viewModel.add().toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          backgroundColor: AppConstants.appColor.buttonColor3,
                          buttonHeight: 35,
                          buttonCurve: 2.0,
                          //buttonWidth: 100,
                          onPressedCallback: () {
                            widget.addToCard();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
                onPressedCallback: () {
                  widget.saveToWishlist();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
