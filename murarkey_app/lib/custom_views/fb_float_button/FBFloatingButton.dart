import 'package:flutter/material.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/open_social_media/OpenFacebookApp.dart';

/**
 * Created by Suman Prasad Neupane on 6/10/2021.
 */
class FBFloatingButton {
  Widget fab() {
    return FloatingActionButton(
        // isExtended: true,
        //mini: true,
        child: Image.asset(
          "images/ic_facebook.png",
          height: 20,
          width: 20,
          color: AppConstants.appColor.primaryColor,
        ),
        backgroundColor: AppConstants.appColor.accentColor,
        onPressed: () {
          OpenFacebookApp(
              pageId: AppConstants.constants.FACEBOOK_PAGE_ID,
              pageName: AppConstants.constants.FACEBOOK_PAGE_NAME);
        });
  }
}
