import 'package:url_launcher/url_launcher.dart';

/**
 * Created by Suman Prasad Neupane on 6/10/2021.
 */

class OpenSocialMedia {
  void lunchMedia({String fbProtocolUrl, String fallbackUrl}) async {
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }
}
