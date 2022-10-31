import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';

class CustomAnimation extends EasyLoadingAnimation {
  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: Loader2Widget(
          radius: 30,
          dotRadius: 5.0,
        ),
      ),
    );
  }
}

class EasyLoadingView {
  static init() {
    return EasyLoading.init();
  }

  static instance() {
    return EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      // ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 60.0
      // ..progressColor = Colors.yellow
      // ..backgroundColor = Colors.green
      // ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  static show({
    String message = "",
  }) {
    return EasyLoading.show(
      status: message,
      indicator: Loader2Widget(
        radius: 30,
        dotRadius: 5.0,
      ),
      //maskType: EasyLoadingMaskType.custom
    );
  }

  static dismiss() {
    return EasyLoading.dismiss();
  }
}
