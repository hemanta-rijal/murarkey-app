import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/local/LoadHtml.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorServicesModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/error/ServiceNotAvailableWidget.dart';
import 'package:murarkey_app/views/product/view_model/ProductDetailViewModel.dart';
import 'package:murarkey_app/views/product/widgets/ProductToCardWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class ParlorCardItemWidget extends StatefulWidget {
  final List<ServicesCategoryListsModel> modelList;
  final Function(List<ServicesCategoryListsModel>, int) cardTappedAt;

  const ParlorCardItemWidget({Key key, this.modelList, this.cardTappedAt})
      : super(key: key);

  @override
  _ParlorCardItemWidgetState createState() => _ParlorCardItemWidgetState();
}

class _ParlorCardItemWidgetState extends State<ParlorCardItemWidget> {
  Repository _repository = new Repository();

  addToCartToServer(ServicesCategoryListsModel model) async {
    //Add product
    Map<String, dynamic> params = new Map();
    params["product_id"] = model.id.toString();
    params["qty"] = 1.toString();

    params["type"] = "service";
    params["options"] = {
      "image": model.featured_image,
      "product_type": "service"
    };

    print(params);

    await _repository.productRequestApi
        .addToCard(url: ApiUrls.CART, params: params)
        .then((value) {
      if (value != null) {
        Commons.toastMessage(context, value["message"]);
      }
      this.setState(() {});
    });
  }

  Widget shortDecription(short_description) {
    return Container(
      child: Html(
        shrinkWrap: true,
        data: "${short_description}",
        style: {
          "body": Style(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
          ),
        },
        //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
      ),
    );
  }

  Widget cardItem(int position, ServicesCategoryListsModel model) {
    ProductDetailViewModel viewModel = new ProductDetailViewModel();

    return Container(
      padding: EdgeInsets.only(
          top: position == 0 ? 16 : 16,
          left: 8,
          right: 8,
          bottom: 16), //position == servicesCategoryList.length - 1 ? 16 : 16),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.network(
                      model.featured_image,
                      width: GlobalData.size.width * 0.3,
                      height: GlobalData.size.width * 0.35,
                      fit: BoxFit.cover,
                    ),
                    FlatButton3(
                      text: "SELL",
                      fontSize: SizeConfig.textMultiplier * 1.8,
                      textColor: AppConstants.appColor.whiteColor,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      backgroundColor: Colors.green,
                      buttonHeight: 30,
                      buttonWidth: GlobalData.size.width * 0.3,
                      buttonCurve: 1.2,
                      fontWeight: FontWeight.w800,
                      boderColor: Colors.green,
                      onPressedCallback: () {},
                    ),
                  ],
                ),
                Container(
                  //width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "${model.title}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConstants.appColor.blackColor,
                            fontSize: SizeConfig.textMultiplier * 2.2,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: "Rs. ${model.service_charge}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConstants.appColor.blackColor,
                            fontSize: SizeConfig.textMultiplier * 2.1,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppConstants.appColor.backgroundColor3,
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 16),
                          RichText(
                            text: TextSpan(
                              text: "${model.duration}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 2.0,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // SizedBox(height: 12),
                      // Container(
                      //   width: 145,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     border: Border.all(
                      //         width: 2, color: AppConstants.appColor.greyColor),
                      //     borderRadius: BorderRadius.all(Radius.circular(2)),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(left: 4.0, right: 4.0),
                      //         child: InkResponse(
                      //           child: svgImageAssert2(
                      //             imgUrl: "images/maths/ic_sub_2.svg",
                      //             size: 16,
                      //             color: AppConstants.appColor.greyColor,
                      //           ),
                      //           onTap: () {
                      //             setState(() {
                      //               viewModel.formAddToCardItem.text =
                      //                   viewModel.subtract().toString();
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 4.0, right: 4.0),
                      //         width: 80,
                      //         child: textFieldDisableKeyboard(
                      //           textAlign: TextAlign.center,
                      //           borderColor: AppConstants.appColor.whiteColor,
                      //           height: 30,
                      //           controller: viewModel.formAddToCardItem,
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 4.0, right: 4.0),
                      //         child: InkResponse(
                      //           child: svgImageAssert2(
                      //             imgUrl: "images/maths/ic_add_2.svg",
                      //             size: 16,
                      //             color: AppConstants.appColor.greyColor,
                      //           ),
                      //           onTap: () {
                      //             setState(() {
                      //               viewModel.formAddToCardItem.text =
                      //                   viewModel.add().toString();
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 4),
                      FlatButton3(
                        text: "ADD TO CARD",
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        textColor: AppConstants.appColor.redColor,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        backgroundColor: AppConstants.appColor.backgroundColor2,
                        //buttonWidth: 145,
                        buttonHeight: 35,
                        buttonCurve: 1.2,
                        fontWeight: FontWeight.w800,
                        boderColor: AppConstants.appColor.redColor,
                        //buttonWidth: 100,
                        onPressedCallback: () {
                          addToCartToServer(model);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            shortDecription(model.short_description),
            SizedBox(height: 20),
            InkResponse(
              onTap: () {
                widget.cardTappedAt(widget.modelList, position);
              },
              child: RichText(
                text: TextSpan(
                  text: "VIEW DETAILS",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[600],
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      decoration: TextDecoration.underline),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      itemCount: widget.modelList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black38,
          thickness: 8,
          height: 1,
        );
      },
      itemBuilder: (context, position) {
        return cardItem(position, widget.modelList[position]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.modelList != null && widget.modelList.length > 0
          ? listView()
          : ServiceNotAvailableWidget(),
    );
  }
}
