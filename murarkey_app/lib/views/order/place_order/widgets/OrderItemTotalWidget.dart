import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/31/2021.
 */

class OrderItemTotalWidget extends StatelessWidget {
  final String subTotal;
  final String tax;
  final String shippingCharge;
  final String total;
  final Widget componentView;

  const OrderItemTotalWidget({
    Key key,
    this.subTotal,
    this.tax,
    this.shippingCharge,
    this.total,
    this.componentView,
  }) : super(key: key);

  Widget loadEachAmount(
      {String title, String body, EdgeInsetsGeometry margin}) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Expanded(
            child: textView1(
                title: "${title}",
                textSize: 2.0,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.start),
          ),
          Expanded(
            child: textView1(
                title: "${body}",
                textSize: 2.0,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget loadPriceBuilder() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 4,
              right: 4,
              top: 8,
              bottom: 4,
            ),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "Order Amount: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.appColor.blackColor,
                      fontSize: SizeConfig.textMultiplier * 2.3,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          loadEachAmount(
            title: "Sub Total: ",
            body: "Rs ${subTotal}",
            margin: EdgeInsets.all(4),
          ),
          loadEachAmount(
            title: "Tax: ",
            body: "Rs ${tax}",
            margin: EdgeInsets.all(4),
          ),
          loadEachAmount(
            title: "Shipping: ",
            body: "Rs ${shippingCharge}",
            margin: EdgeInsets.all(4),
          ),
          componentView != null
              ? Container(
                  child: componentView,
                  margin: EdgeInsets.all(4),
                )
              : Container(),
          componentView != null
              ? Container(
                  margin: EdgeInsets.only(bottom: 8),
                )
              : Container(),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 1,
                color: Colors.grey,
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 4,
              right: 4,
              top: 8,
              bottom: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: textView1(
                      title: "Total: ",
                      textSize: 2.0,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start),
                ),
                Expanded(
                  child: textView1(
                      title: "Rs ${total}",
                      textSize: 2.3,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [Expanded(flex: 1, child: loadPriceBuilder())],
      ),
    );
  }
}
