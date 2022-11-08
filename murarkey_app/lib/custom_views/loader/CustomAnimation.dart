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
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 60.0
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..dismissOnTap = false
      ..contentPadding = EdgeInsets.zero
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
    );
  }

  static dismiss() {
    return EasyLoading.dismiss();
  }
}
