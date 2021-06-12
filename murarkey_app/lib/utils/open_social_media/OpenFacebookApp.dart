import 'dart:io';

import 'package:murarkey_app/utils/open_social_media/OpenSocialMedia.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * Created by Suman Prasad Neupane on 6/10/2021.
 */

class OpenFacebookApp extends OpenSocialMedia {
  //https://www.facebook.com/murarkey
  //https://www.facebook.com/EagleyeTechnology/
  //page id = 395985173802030
  //page name = EagleyeTechnology
  OpenFacebookApp({String pageId, String pageName}) {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/' + pageId;
    } else {
      fbProtocolUrl = 'fb://page/' + pageId;
    }

    String fallbackUrl = 'https://www.facebook.com/' + pageName;
    super.lunchMedia(fbProtocolUrl: fbProtocolUrl, fallbackUrl: fallbackUrl);
  }
}
