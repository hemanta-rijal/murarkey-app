import 'dart:io';

import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/open_social_media/OpenFacebookApp.dart';
import 'package:url_launcher/url_launcher.dart';

//https://medium.com/flutter-community/build-a-chatbot-in-20-minutes-using-flutter-and-dialogflow-8e9af1014463
//https://stackoverflow.com/questions/55838430/flutter-open-facebook-link-in-facebook-app-android-ios

class MessagesFragmentWidget extends StatefulWidget {
  @override
  _MessagesFragmentWidgetState createState() => _MessagesFragmentWidgetState();
}

class _MessagesFragmentWidgetState
    extends CustomStatefulWidgetState<MessagesFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return render(
        childWidget: Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            OpenFacebookApp(
                pageId: AppConstants.constants.FACEBOOK_PAGE_ID,
                pageName: AppConstants.constants.FACEBOOK_PAGE_NAME);
          },
          child: Text('Show Flutter homepage'),
        ),
      ),
    ));
  }
}
