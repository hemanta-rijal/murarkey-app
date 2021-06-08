import 'package:flutter_svg/svg.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/8/2021.
 */

svgImageAssert({String imgUrl, color, }){
  color = color ?? AppConstants.appColor.whiteColor;

  return SvgPicture.asset(
    imgUrl,
    color: color,
    width: 20,
    height: 20,
  );
}