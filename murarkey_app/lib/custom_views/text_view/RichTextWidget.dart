import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/25/2021.
 */

richText1(){
  return  RichText(
    text: TextSpan(
      text:
      AppConstants.constants.PRIVACY_POLICY_MSG,
      style: TextStyle(
        color: AppConstants.appColor.textColor3,
        fontSize: SizeConfig.textMultiplier * 1.4,
      ),
      children: <TextSpan>[
        TextSpan(
            text: AppConstants.constants.PRIVACY_POLICY,
            style: TextStyle(
              color: AppConstants.appColor.primaryDarkColor,
              fontSize: SizeConfig.textMultiplier * 1.55,
            )),
      ],
    ),
    textAlign: TextAlign.justify,
  );
}
