import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/15/2021.
 */

class ServiceNotAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Service not available.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppConstants.appColor.blackColor,
              fontSize: SizeConfig.textMultiplier * 2.6,
            ),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
