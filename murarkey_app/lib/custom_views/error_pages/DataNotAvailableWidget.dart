import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/15/2021.
 */

class DataNotAvailableWidget extends StatelessWidget {
  final String message;

  const DataNotAvailableWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RichText(
          text: TextSpan(
            text: message,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppConstants.appColor.blackColor,
              fontSize: SizeConfig.textMultiplier * 2.2,
            ),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
