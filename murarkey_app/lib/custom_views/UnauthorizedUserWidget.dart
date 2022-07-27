import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';

class UnauthorizedUserWidget extends StatefulWidget {
  const UnauthorizedUserWidget({Key key}) : super(key: key);

  @override
  State<UnauthorizedUserWidget> createState() => _UnauthorizedUserWidgetState();
}

class _UnauthorizedUserWidgetState extends State<UnauthorizedUserWidget> {
  Size size;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/ic_login_required.png",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 48),
            Text("Login to unlock all feature!"),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: FlatStatefulButton(
                text: "Sign in",
                fontSize: SizeConfig.textMultiplier * 1.8,
                textColor: AppConstants.appColor.whiteColor,
                padding: EdgeInsets.all(size.width * .02),
                backgroundColor: AppConstants.appColor.buttonColor3,
                buttonHeight: 45,
                buttonCurve: 0.0,
                //buttonWidth: 100,
                onPressedCallback: () {
                  NavigateRoute.popAndPushNamed(
                    context,
                    NavigateRoute.LOGIN,
                  );
                },
              ),
            ),
            //SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
