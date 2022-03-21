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
class SkinToneWidget extends StatefulWidget {
  const SkinToneWidget({Key key}) : super(key: key);

  @override
  _SkinToneWidgetState createState() => _SkinToneWidgetState();
}

class _SkinToneWidgetState extends CustomStatefulWidgetState<SkinToneWidget> {
  // List<String> lists = [
  //   "Normal skin",
  //   "Dry skin",
  //   "Mature skin",
  //   "Oily skin",
  //   "Combination skin",
  //   "All skin type",
  // ];
  var skinVarient = GlobalData.skinVarientModelList[0];

  void next({int index = -1}) {
    if (index > -1) {
      GlobalData.skinVarientModelValue["${skinVarient.slug}"] =
          "${skinVarient.data[index].slug}";
    }
    NavigateRoute.pushNamed(
      context,
      NavigateRoute.SKIN_CONCERN,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget builder() {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                  dotActiveAt: 1,
                  leftButtonName: "Skip",
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
      bodybackgroundColor: AppConstants.appColor.purpleColor,
      childWidget: builder(),
    );
  }
}
