import 'package:flutter/widgets.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/custom_views/buttons/FlatStatefulButton2.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubSubModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/widget/ServiceNotAvailableWidget.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class ServiceCardItemWidget extends StatefulWidget {
  final OurServicesSubSubModel model;

  const ServiceCardItemWidget({Key key, this.model}) : super(key: key);

  @override
  _ServiceCardItemWidgetState createState() => _ServiceCardItemWidgetState();
}

class _ServiceCardItemWidgetState extends State<ServiceCardItemWidget> {
  Repository _repository = new Repository();
  List<ServicesCategoryListsModel> servicesCategoryList = new List();

  @override
  void initState() {
    _repository.servicesApiRequest
        .getServicesListFromCategory(
            url: ApiUrls.SERVICES_CATEGORY_LIST(widget.model.id.toString()))
        .then((value) {
      servicesCategoryList = value;
      this.setState(() {});
    });
    super.initState();
  }

  Widget cardItem(int position, ServicesCategoryListsModel model) {
    return Container(
      //width: double.infinity,
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
                      FlatButton3(
                        text: "ADD TO CARD",
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
                          //widget.saveToWishlist();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 16),
            // RichText(
            //   text: TextSpan(
            //     text: "${model.title}",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: AppConstants.appColor.blackColor,
            //       fontSize: SizeConfig.textMultiplier * 2.2,
            //     ),
            //   ),
            //   textAlign: TextAlign.justify,
            // ),
            // SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: "${model.short_description}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppConstants.appColor.blackColor,
                  fontSize: SizeConfig.textMultiplier * 2.0,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            RichText(
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
            // Container(
            //   padding: EdgeInsets.only(
            //     bottom: 3, // space between underline and text
            //   ),
            //   decoration: BoxDecoration(
            //       border: Border(bottom: BorderSide(
            //         color: Colors.blueAccent,  // Text colour here
            //         width: 1.0, // Underline width
            //       ))
            //   ),
            //   child: Text(
            //     "VIEW DETAILS",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w900,
            //       fontSize: SizeConfig.textMultiplier * 1.8,
            //       color: Colors.blueAccent,  // Text colour here
            //     ),
            //   ),
            // )
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
          ?listView()
          : ServiceNotAvailableWidget(),
    );
  }
}
