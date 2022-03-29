import 'package:flutter_html/flutter_html.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/17/2021.
 */

class CardDeatilDescriptionWidget extends StatefulWidget {
  final ServicesCategoryListsModel model;
  final String parentTitle;
  final int position;

  const CardDeatilDescriptionWidget(
      {Key key, this.model, this.position, this.parentTitle})
      : super(key: key);

  @override
  _CardDeatilDescriptionWidgetState createState() =>
      _CardDeatilDescriptionWidgetState();
}

class _CardDeatilDescriptionWidgetState
    extends State<CardDeatilDescriptionWidget> {
  bool checked = false;

  Repository _repository = new Repository();

  addToCartToServer() async {
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

  Widget loadBannerImage() {
    return Image.network(
      widget.model.featured_image,
      height: 230,
      fit: BoxFit.cover,
      width: double.infinity,
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

  Widget productPrice() {
    if (widget.model == null) {
      return Container();
    } else if (widget.model.price_after_discount == null) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(left: 8),
      child: RichText(
        text: TextSpan(
          text: widget.model != null
              ? "Rs " + widget.model.price_after_discount.toString()
              : "Rs 0",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppConstants.appColor.blackColor,
            fontSize: SizeConfig.textMultiplier * 2.6,
          ),
          children: <TextSpan>[
            TextSpan(text: " "),
            widget.model.price_after_discount != widget.model.price
                ? TextSpan(
              text: widget.model != null
                  ? "Rs " + widget.model.price.toString()
                  : "Rs 0",
              style: TextStyle(
                color: AppConstants.appColor.greyColor,
                fontSize: SizeConfig.textMultiplier * 2.6,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 1.2,
                decorationColor: AppConstants.appColor.redColor,
              ),
            )
                : TextSpan(text: ""),
            TextSpan(text: " "),
            widget.model.price_after_discount != widget.model.price
                ? TextSpan(
              text: widget.model != null &&
                  widget.model.discount_rates != null
                  ? "${widget.model.discount_rates.toString()}%"
                  : "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.appColor.redColor,
                fontSize: SizeConfig.textMultiplier * 2.6,
              ),
            )
                : TextSpan(text: ""),
          ],
        ),
        //textAlign: TextAlign.justify,
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
            productPrice(),
          ],
        ));
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loadBannerImage(),
            loadTitle(),
            divider(),
            columnDurationAndCart(),
            divider(),
            description(),
            divider(),
            labels(),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
