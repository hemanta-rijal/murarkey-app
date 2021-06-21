import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/21/2021.
 */

class ShippingAndBillingWidget {
  static _subView(IconData icon, String str) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppConstants.appColor.blackColor,
          size: 14,
        ),
        SizedBox(width: 4),
        textView1(
            title: str,
            textAlign: TextAlign.start,
            color: AppConstants.appColor.blackColor,
            textSize: 1.2,
            fontWeight: FontWeight.normal),
      ],
    );
  }

  static Widget get() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textView1(
              title: "Shipping and Billing",
              textAlign: TextAlign.left,
              color: AppConstants.appColor.blackColor,
              textSize: 1.3,
              fontWeight: FontWeight.bold),
          SizedBox(height: 4),
          _subView(Icons.location_on, "Dhungeadda Kathmandu, 32007"),
          _subView(Icons.call, "9866010578"),
          _subView(Icons.email, "ghanshyam21@gmail.com"),
        ],
      ),
    );
  }
}
