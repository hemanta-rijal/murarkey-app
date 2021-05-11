import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static var _mediaQueryData;

  static double screenWidth;
  static var orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    orientation =  MediaQuery.of(context).orientation;

    if (_mediaQueryData.orientation == Orientation.portrait) {
      _screenWidth = _mediaQueryData.size.width;
      _screenHeight = _mediaQueryData.size.height;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = _mediaQueryData.size.height;
      _screenHeight = _mediaQueryData.size.width;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    screenWidth = _screenWidth;

    print(_screenWidth);
  }

}



  // class SizeConfig {
  //   static MediaQueryData _mediaQueryData;
  //   static double screenWidth;
  //   static double screenHeight;
  //   static double blockSizeHorizontal;
  //   static double blockSizeVertical;
  //
  //   static double _safeAreaHorizontal;
  //   static double _safeAreaVertical;
  //   static double safeBlockHorizontal;
  //   static double safeBlockVertical;
  //
  //   void init(BuildContext context) {
  //   _mediaQueryData = MediaQuery.of(context);
  //   screenWidth = _mediaQueryData.size.width;
  //   screenHeight = _mediaQueryData.size.height;
  //   blockSizeHorizontal = screenWidth / 100;
  //   blockSizeVertical = screenHeight / 100;
  //
  //   // space containing appbars and bar which contains wifi and network
  //   _safeAreaHorizontal = _mediaQueryData.padding.left +
  //   _mediaQueryData.padding.right;
  //   _safeAreaVertical = _mediaQueryData.padding.top +
  //   _mediaQueryData.padding.bottom;
  //   // substract the unwanted space safeAreaHorizontal
  //   safeBlockHorizontal = (screenWidth -
  //   _safeAreaHorizontal) / 100;
  //   safeBlockVertical = (screenHeight -
  //   _safeAreaVertical) / 100;
  //   }
  //   }