import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/ImageSliderWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/custom_views/review/ReviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/our_services/widget/price/ProductPriceWidget.dart';
import 'package:share_plus/share_plus.dart';

/**
 * Created by Suman Prasad Neupane on 7/17/2021.
 */

class CardDeatilDescriptionWidget extends StatefulWidget {
  final ServicesCategoryListsModel model;
  final String parentTitle;
  final int position;
  final Function callback;

  const CardDeatilDescriptionWidget({
    Key key,
    this.model,
    this.position,
    this.parentTitle,
    this.callback,
  }) : super(key: key);

  @override
  _CardDeatilDescriptionWidgetState createState() =>
      _CardDeatilDescriptionWidgetState();
}

class _CardDeatilDescriptionWidgetState
    extends State<CardDeatilDescriptionWidget> {
  bool checked = false;

  Repository _repository = new Repository();

  addToCartToServer() async {
    var check = await Commons.checkNetworkConnectivity();
    if (!check) {
      EasyLoading.show(
        status: "",
        indicator: Connectivity2Widget(
          retry: () {
            addToCartToServer();
          },
          cancel: () {
            EasyLoading.dismiss();
          },
        ),
        maskType: EasyLoadingMaskType.custom,
      );
      return;
    } else {
      //Add service
      Map<String, dynamic> params = new Map();
      params["product_id"] = widget.model.id.toString();
      params["qty"] = 1.toString();

      params["type"] = "service";
      params["options"] = {
        "image": widget.model.featured_image,
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
  }

  Widget loadBannerImage() {
    // return Image.network(
    //   widget.model.featured_image,
    //   height: 230,
    //   fit: BoxFit.cover,
    //   width: double.infinity,
    // );

    if (widget.model == null) {
      return Container();
    } else if (widget.model.images == null) {
      return Container();
    } else if (widget.model.images.length < 0) {
      return Container();
    }

    return Container(
      color: AppConstants.appColor.whiteColor,
      child: ImageSliderWidget(
        bannerModelList: widget.model.images,
        bannerHeight: 230,
        imageFit: BoxFit.contain,
        backgroundColor: AppConstants.appColor.whiteColor,
        //bannerWidth: 200,
      ),
    );
  }

  Widget divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black26,
    );
  }

  Widget loadTitle() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.model.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.appColor.blackColor,
                fontSize: SizeConfig.textMultiplier * 2.8,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          RichText(
            text: TextSpan(
              text: widget.parentTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.appColor.greyColor,
                fontSize: SizeConfig.textMultiplier * 2.6,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget loadDuration() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  color: Colors.orange[700],
                  size: 30,
                ),
              ),
              SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  text: "${widget.model.duration}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                    fontSize: SizeConfig.textMultiplier * 2.0,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          SizedBox(height: 4),
          //productPrice(),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: ProductPriceWidget(
              model: widget.model,
            ),
          )
        ],
      ),
    );
  }

  Widget description() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Description".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
                fontSize: SizeConfig.textMultiplier * 2.6,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Html(
            data: widget.model.description,
            style: {
              "body": Style(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
              ),
            },
            //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
          )
        ],
      ),
    );
  }

  Widget labels() {
    List<Widget> lableLists = [];
    if (widget.model.labels != null) {
      widget.model.labels.forEach((key, value) {
        lableLists.add(
          Container(
            margin: EdgeInsets.only(left: 16, top: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "${key}".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      fontSize: SizeConfig.textMultiplier * 2.6,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 12),
                Html(
                  data: value,
                  style: {
                    "body": Style(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
                    ),
                  },
                  //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
                )
              ],
            ),
          ),
        );

        lableLists.add(
          divider(),
        );
      });

      return Container(
        child: Column(
          children: lableLists,
        ),
      );
    }

    return Container();
  }

  Widget reviews() {
    if (widget.model == null) {
      return Container();
    } else if (widget.model.reviews == null) {
      return Container();
    } else if (widget.model.reviews.length < 1) {
      return Container();
    }

    print("reviews---------> ${widget.model.reviews}");
    return ReviewWidget(
      reviewable: widget.model.reviewable,
      model: widget.model.reviews,
      averageRate: widget.model.average_review,
      callback: (String rating, String comment) async {
        Map<String, dynamic> queryParams = new Map();
        queryParams["rating"] = rating;
        queryParams["comment"] = comment;
        queryParams["type"] = "service";
        queryParams["service_id"] = widget.model.id;
        String value = await _repository.reviewApi.postReview(
          url: ApiUrls.ADD_REVIEW,
          queryParams: queryParams,
        );

        if (value != null) {
          Commons.toastMessage(context, value);
          widget.callback();
        }
      },
    );
  }

  Widget columnDurationAndCart() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: loadDuration(),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                addToCartToServer();
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              alignment: Alignment.centerRight,
              child: svgImageAssert2(
                imgUrl: "images/cart/ic_add_to_cart.svg",
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shareToSocialMedia() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 16, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Share.share(
                  '${widget.model.web_url}',
                  subject: 'Murarkey',
                );
              },
              child: Icon(
                Icons.share,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loadBannerImage(),
            loadTitle(),
            shareToSocialMedia(),
            divider(),
            columnDurationAndCart(),
            divider(),
            description(),
            divider(),
            labels(),
            reviews(),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
