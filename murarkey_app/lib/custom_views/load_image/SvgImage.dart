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

svgImageAssert2({String imgUrl, double size}){
  return SvgPicture.asset(
    imgUrl,
    width: size,
    height: size,
  );
}

svgImageAssert3({String imgUrl, color,  double size}){
  color = color ?? AppConstants.appColor.whiteColor;

  return SvgPicture.asset(
    imgUrl,
    color: color,
    width: size,
    height: size,
  );
}
