import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/views/best_product_for_you/widget/BodyWidget.dart';
import 'package:murarkey_app/views/best_product_for_you/widget/FooterWidget.dart';
import 'package:murarkey_app/views/best_product_for_you/widget/HearderWidget.dart';

/**
 * Created by Suman Prasad Neupane on 3/15/2022.
 */
class SkinConcernsWidget extends StatefulWidget {
  const SkinConcernsWidget({Key key}) : super(key: key);

  @override
  _SkinConcernsWidgetState createState() => _SkinConcernsWidgetState();
}

class _SkinConcernsWidgetState
    extends CustomStatefulWidgetState<SkinConcernsWidget> {
  // List<String> lists = [
  //   "Acne and Blemishes",
  //   "Signs of Aging",
  //   "Pores",
  //   "Uneven Skin Tone and Roughness",
  //   "Dark Circles and Puffiness",
  //   "Sensitive Skin",
  //   "Very Dry Skin",
  // ];
  var skinVarient = GlobalData.skinVarientModelList[1];

  void next({int index = -1}) {
    if (index > -1) {
      GlobalData.skinVarientModelValue["${skinVarient.slug}"] =
          "${skinVarient.data[index].slug}";
    }
    NavigateRoute.pushNamed(
      context,
      NavigateRoute.SKIN_PRODUCT_TYPE,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget builder() {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              HearderWidget(
                title: skinVarient.title,
                desc: skinVarient.detail,
              ),
              SizedBox(height: 32),
              BodyWidget(
                lists: skinVarient.data,
                onTapList: (int index) {
                  next(index: index);
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                FooterWidget(
                  noOfDots: 3,
                  dotActiveAt: 2,
                  leftButtonName: "Previous",
                  rightButtonName: "Next",
                  leftButtonTap: () {
                    NavigateRoute.pop(context);
                  },
                  rightButtonTap: () {
                    next();
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ],
      );
    }

    return render(
      bodybackgroundColor: AppConstants.appColor.greenColor2,
      childWidget: builder(),
    );
  }
}
