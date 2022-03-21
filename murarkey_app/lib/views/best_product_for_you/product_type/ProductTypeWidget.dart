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
class ProductTypeWidget extends StatefulWidget {
  const ProductTypeWidget({Key key}) : super(key: key);

  @override
  _ProductTypeWidgetState createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState
    extends CustomStatefulWidgetState<ProductTypeWidget> {
  // List<String> lists = [
  //   "Cleanser",
  //   "Toner",
  //   "Serum",
  //   "Moisturizer",
  //   "Sunscreen",
  //   "All Products",
  // ];

  var skinVarient = GlobalData.skinVarientModelList[2];

  void next({int index = -1}) {
    if (index > -1) {
      GlobalData.skinVarientModelValue["${skinVarient.slug}"] =
          "${skinVarient.data[index].slug}";
    }
    Map<String, dynamic> arguments = new Map();
    arguments["categoryModelList"] = GlobalData.categoryModelList;
    arguments["brandModelList"] = GlobalData.brandModelList;
    arguments["skinVarientModelMap"] = GlobalData.skinVarientModelValue;
    print("skinVarientModelMap----------> ${GlobalData.skinVarientModelValue}");
    GlobalData.skinVarientModelValue = {};
    NavigateRoute.pushNamedWithArguments(
      context,
      NavigateRoute.SEARCH,
      arguments,
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
                  dotActiveAt: 3,
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
      bodybackgroundColor: AppConstants.appColor.orangeColor,
      childWidget: builder(),
    );
  }
}
