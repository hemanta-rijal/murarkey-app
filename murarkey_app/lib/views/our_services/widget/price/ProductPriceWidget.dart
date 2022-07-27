import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

/**
 * Created by Suman Prasad Neupane on 4/3/2022.
 */
class ProductPriceWidget extends StatefulWidget {
  ServicesCategoryListsModel model;
  double actualFontSize;
  double discountFontSize;
  double percentageFontSize;
  double width;

  ProductPriceWidget({
    Key key,
    this.model,
    this.width,
    double actualFontSize,
    double discountFontSize,
    double percentageFontSize,
  }) : super(key: key) {
    this.actualFontSize = actualFontSize == null
        ? SizeConfig.textMultiplier * 2.6
        : actualFontSize;
    this.discountFontSize = actualFontSize == null
        ? SizeConfig.textMultiplier * 2.6
        : discountFontSize;
    this.percentageFontSize = actualFontSize == null
        ? SizeConfig.textMultiplier * 2.6
        : percentageFontSize;
  }

  @override
  _ProductPriceWidgetState createState() => _ProductPriceWidgetState();
}

class _ProductPriceWidgetState extends State<ProductPriceWidget> {
  check() {
    if (widget.model.price_after_discount != widget.model.price &&
        widget.model.discount_type == "percentage") {
      return "%";
    } else if (widget.model.price_after_discount != widget.model.price &&
        widget.model.discount_type == "flat_rate") {
      return "off";
    }
    return "";
  }

  Widget productPrice() {
    if (widget.model == null) {
      return Container();
    } else if (widget.model.price_after_discount == null) {
      return Container();
    }

    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            //overflow: TextOverflow.ellipsis,
            softWrap: true,
            text: TextSpan(
              text: widget.model != null
                  ? "Rs " + widget.model.price_after_discount.toString()
                  : "Rs 0",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppConstants.appColor.blackColor,
                fontSize: widget.actualFontSize,
              ),
              children: <TextSpan>[
                TextSpan(text: " "),
                // widget.model.price_after_discount != widget.model.price
                //     ? TextSpan(
                //         text: widget.model != null
                //             ? "Rs " + widget.model.price.toString()
                //             : "Rs 0",
                widget.model.price_after_discount != widget.model.price &&
                        (widget.model.discount_type == "percentage" ||
                            widget.model.discount_type == "flat_rate")
                    ? TextSpan(
                        text: widget.model != null
                            ? "Rs " + widget.model.price.toString()
                            : "Rs 0",
                        style: TextStyle(
                          color: AppConstants.appColor.greyColor,
                          fontSize: widget.discountFontSize,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 1.2,
                          decorationColor: AppConstants.appColor.redColor,
                        ),
                      )
                    : TextSpan(text: ""),
                TextSpan(text: " "),
              ],
            ),
          ),
          RichText(
            text: widget.model.price_after_discount != widget.model.price &&
                    (widget.model.discount_type == "percentage" ||
                        widget.model.discount_type == "flat_rate")
                ? TextSpan(
                    // text: widget.model != null &&
                    //         widget.model.discount_rates != null
                    //     ? "${widget.model.discount_rates.toString()}%"
                    //     : "",
                    text: widget.model != null &&
                            widget.model.discount_rates != null
                        ? "${check() == "%" ? "${widget.model.discount_rates.toString()}%" : "Rs. ${widget.model.discount_rates.toString()} off"}"
                        : "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppConstants.appColor.redColor,
                      fontSize: widget.percentageFontSize,
                    ),
                  )
                : TextSpan(text: ""),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return productPrice();
  }
}
