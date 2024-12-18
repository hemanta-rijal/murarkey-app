import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/local/LoadHtml.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/widget/price/ProductPriceWidget.dart';
import '../../error/ServiceNotAvailableWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class ServiceCardItemWidget extends StatefulWidget {
  final OurServicesSubSubModel model;
  final Function(List<ServicesCategoryListsModel>, int) cardTappedAt;

  const ServiceCardItemWidget({Key key, this.model, this.cardTappedAt})
      : super(key: key);

  @override
  _ServiceCardItemWidgetState createState() => _ServiceCardItemWidgetState();
}

class _ServiceCardItemWidgetState extends State<ServiceCardItemWidget> {
  Repository _repository = new Repository();
  List<ServicesCategoryListsModel> servicesCategoryList = new List();
  bool loading = false;

  @override
  void initState() {
    EasyLoadingView.show(message: 'Loading...');
    _repository.servicesApiRequest
        .getServicesListFromCategory(
      url: ApiUrls.SERVICES_CATEGORY_LIST(
        widget.model.id.toString(),
      ),
    )
        .then((value) {
      servicesCategoryList = value;
      EasyLoadingView.dismiss();
      loading = true;
      this.setState(() {});
    });
    super.initState();
  }

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

    EasyLoadingView.show(message: 'Adding to cart...');
    await _repository.productRequestApi
        .addToCard(url: ApiUrls.CART, params: params)
        .then((value) {
      try {
        if (value != null) {
          Commons.toastMessage(context, value["message"]);
        } else {
          Commons.toastMessage(context, "Please login to Add service to cart.");
        }
      } catch (e) {
        Commons.toastMessage(context, "Please login to Add service to cart.");
      }
      EasyLoadingView.dismiss();
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
    return Container(
      padding: EdgeInsets.only(
          top: position == 0 ? 16 : 16,
          left: 8,
          right: 8,
          bottom: position == servicesCategoryList.length - 1 ? 16 : 16),
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
                  ],
                ),
                Expanded(
                  child: Container(
                    //width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                        ProductPriceWidget(
                          model: model,
                          width: MediaQuery.of(context).size.width * 1 / 2.7,
                          actualFontSize: SizeConfig.textMultiplier * 2.0,
                          discountFontSize: SizeConfig.textMultiplier * 2.0,
                          percentageFontSize: SizeConfig.textMultiplier * 2.0,
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
                        FlatButton3(
                          text: "ADD TO CART",
                          fontSize: SizeConfig.textMultiplier * 1.8,
                          textColor: AppConstants.appColor.redColor,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          backgroundColor: AppConstants.appColor.backgroundColor2,
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
                  ),
                )
              ],
            ),

            SizedBox(height: 16),
            shortDecription(model.short_description),
            //html(),
            SizedBox(height: 20),
            InkResponse(
              onTap: () {
                widget.cardTappedAt(servicesCategoryList, position);
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
      itemCount: servicesCategoryList.length,
      shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black38,
          thickness: 8,
          height: 1,
        );
      },
      itemBuilder: (context, position) {
        return cardItem(position, servicesCategoryList[position]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: servicesCategoryList != null && servicesCategoryList.length > 0
          ? listView()
          : loading
              ? ServiceNotAvailableWidget()
              : Container(),
    );
  }
}
