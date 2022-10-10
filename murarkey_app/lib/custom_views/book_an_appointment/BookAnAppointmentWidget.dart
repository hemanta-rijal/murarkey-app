import 'package:flutter_svg/flutter_svg.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/25/2021.
 */

class BookAnAppointmentWidget extends StatefulWidget {
  Function(String) callback;

  BookAnAppointmentWidget({Key key, this.callback}) : super(key: key);

  @override
  _BookAnAppointmentWidgetState createState() =>
      _BookAnAppointmentWidgetState();
}

class _BookAnAppointmentWidgetState extends State<BookAnAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var _cardSize = 68.0;

    loagSvgImage(String imgUrl) {
      return SvgPicture.network(
        imgUrl,
        color: AppConstants.appColor.whiteColor,
        placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator(),
        ),
      );
    }

    containerGradient() {
      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft,
            colors: [
              AppConstants.appColor.gradientColor2,
              AppConstants.appColor.gradientColor1,
            ],
          ));
    }

    return Container(
      margin: EdgeInsets.only(top: 12, left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            //height: 170,
            //height: double.negativeInfinity,
            width: double.infinity,
            decoration: containerGradient(),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textView1(
                          title: AppConstants.constants.NO_TIME_GO_SALON.toUpperCase(),
                          textSize: 2.4,
                          color: AppConstants.appColor.whiteColor,
                          fontWeight: FontWeight.bold),
                      textView1(
                          title: AppConstants.constants.MURARKEY_PROVIDES,
                          textSize: 1.8,
                          color: AppConstants.appColor.whiteColor,
                          margin: EdgeInsets.only(top: 8)),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(top: 20),
                        child: new FlatStatefulButton(
                          text: AppConstants.constants.BOOK_AN_APPOINTMENT,
                          fontSize: SizeConfig.textMultiplier * 1.8,
                          textColor: AppConstants.appColor.whiteColor,
                          padding: EdgeInsets.all(screenSize.width * .02),
                          backgroundColor: AppConstants.appColor.buttonColor2,
                          buttonHeight: 35,
                          onPressedCallback: () {
                            NavigateRoute.pushNamed(
                                context, NavigateRoute.BOOK_APPOINTMENT);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.0),
                    child: Container(
                      width: screenSize.width / 3,
                      height: screenSize.width / 3,
                      child: loagSvgImage(
                          "http://murarkey.surge.sh/img/icons/woman-hair.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
