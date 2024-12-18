import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/payment_card_address/PaymentCardAddresModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/21/2021.
 */

class ShippingAndBillingWidget {
  static _subView(IconData icon, String str, double textContainerWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.deepPurple[700],
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          padding: EdgeInsets.all(4),
          child: Icon(
            icon,
            color: AppConstants.appColor.whiteColor,
            size: 11,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            alignment: Alignment.bottomLeft,
            child: textView1(
                title: str,
                textAlign: TextAlign.start,
                color: AppConstants.appColor.blackColor,
                textSize: 1.5,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  static _subViewSameAddress(
      String str, double textContainerWidth, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 31),
        textView1(
          title: str,
          textAlign: TextAlign.start,
          color: AppConstants.appColor.blackColor,
          textSize: 1.5,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: () {
            NavigateRoute.pushNamed(context, NavigateRoute.ADDRESS_Edit);
          },
          child: Icon(
            Icons.edit,
            color: AppConstants.appColor.redColor,
            size: 14,
          ),
        ),
      ],
    );
  }

  static Widget _horizontalLine() {
    return Column(
      children: [
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 0.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }

  static Widget get({
    String title,
    String address,
    String phoneNo,
    String email,
    Size size,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    @required BuildContext context,
  }) {
    var textContainerWidth = (size.width / 2) - 42 - 4;
    return Container(
      margin: margin,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textView1(
              title: title,
              textAlign: TextAlign.left,
              color: AppConstants.appColor.primaryColor,
              textSize: 2.4,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8),
            _subView(Icons.location_on, "${address}, (${phoneNo})",
                textContainerWidth),
            SizedBox(height: 8),
            _subViewSameAddress(
                "Bill To Same Address", textContainerWidth, context),
          ],
        ),
      ),
    );
  }
}
