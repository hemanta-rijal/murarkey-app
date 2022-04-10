import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/best_product_for_you/SkinVarientModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/utils/SizeConfig.dart';
import 'package:murarkey_app/views/search/view_model/SearchViewModel.dart';
import 'package:murarkey_app/views/search/widgets/DropDownBrandWidget.dart';
import 'package:murarkey_app/views/search/widgets/DropDownCategoryWidget.dart';
import 'package:smart_select/smart_select.dart';

/**
 * Created by Suman Prasad Neupane on 4/7/2022.
 */
class ProductFilterDilaog {
  ProductFilterDilaog({
    @required BuildContext context,
    @required double height,
    @required double width,
    @required SearchViewModel viewModel,
  }) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: height,
            width: width,
            //margin: EdgeInsets.only(bottom: 32, left: 12, right:12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: SizedBox.expand(
              child: _ProductFilterWidget(
                viewModel: viewModel,
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
    //.whenComplete(() {});
  }
}

class _ProductFilterWidget extends StatefulWidget {
  final SearchViewModel viewModel;

  const _ProductFilterWidget({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _ProductFilterWidgetState createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<_ProductFilterWidget> {
  SkinVarientData skinType;
  SkinVarientData skinConcern;
  SkinVarientData productType;

  categoryTagFilter() {
    return ChipsChoice<CategoryModel>.single(
      value: widget.viewModel.categoryValue,
      wrapped: true,
      onChanged: (val) => setState(() {
        widget.viewModel.categoryValue = widget.viewModel
            .categoryModelList[widget.viewModel.categoryModelList.indexOf(val)];
      }),
      choiceItems: C2Choice.listFrom<CategoryModel, CategoryModel>(
        source: widget.viewModel.categoryModelList,
        value: (i, v) => v,
        label: (i, v) => v.name,
      ),
    );
  }

  skinVarientFilter({
    int index,
    SkinVarientData value,
    SkinVarientModel skinVarient,
    Function(SkinVarientData) callback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        textView1(
          title: "${skinVarient.title}",
          textSize: 2.0,
          textAlign: TextAlign.start,
          color: AppConstants.appColor.blackColor,
          fontWeight: FontWeight.bold,
        ),
        ChipsChoice<SkinVarientData>.single(
          value: value,
          wrapped: true,
          onChanged: (val) => setState(() {
            callback(val);
          }),
          choiceItems: C2Choice.listFrom<SkinVarientData, SkinVarientData>(
            source: skinVarient.data,
            value: (i, v) => v,
            label: (i, v) => v.title,
          ),
        ),
      ],
    );
  }

  Widget skinTypeFilter() {
    int index = 0;
    var skinTypes = GlobalData.skinVarientModelList[index];

    return skinVarientFilter(
      index: index,
      value: skinType,
      skinVarient: skinTypes,
      callback: (SkinVarientData value) {
        GlobalData.skinVarientModelValue["${skinTypes.slug}"] = "${value.slug}";
        skinType = value;
        widget.viewModel.skinVarientModelMap = GlobalData.skinVarientModelValue;
      },
    );
  }

  Widget skinConcernFilter() {
    int index = 1;
    var skinTypes = GlobalData.skinVarientModelList[index];

    return skinVarientFilter(
      index: index,
      value: skinConcern,
      skinVarient: skinTypes,
      callback: (SkinVarientData value) {
        GlobalData.skinVarientModelValue["${skinTypes.slug}"] = "${value.slug}";
        skinConcern = value;
        widget.viewModel.skinVarientModelMap = GlobalData.skinVarientModelValue;
      },
    );
  }

  Widget productTypeFilter() {
    int index = 2;
    var skinTypes = GlobalData.skinVarientModelList[index];

    return skinVarientFilter(
      index: index,
      value: productType,
      skinVarient: skinTypes,
      callback: (SkinVarientData value) {
        GlobalData.skinVarientModelValue["${skinTypes.slug}"] = "${value.slug}";
        productType = value;
        widget.viewModel.skinVarientModelMap = GlobalData.skinVarientModelValue;
      },
    );
  }

  void reset() {
    //Button listener
    widget.viewModel.resetAllParameters();
    widget.viewModel.search();
    widget.viewModel.callSearchApi();
    setState(() {});
  }

  void search() {
    //Button listener
    widget.viewModel.search();
    widget.viewModel.callSearchApi();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Filter by Brands
                                textView1(
                                    title: "Brands",
                                    textSize: 2.0,
                                    textAlign: TextAlign.start,
                                    color: AppConstants.appColor.blackColor,
                                    fontWeight: FontWeight.bold),
                                dropDownBrand(
                                  margin: EdgeInsets.only(top: 4.0),
                                  modelList: widget.viewModel.brandModelList,
                                  value: widget.viewModel.brandValue,
                                  onChange: (value) {
                                    setState(() {
                                      widget.viewModel.brandValue =
                                          widget.viewModel.brandModelList[widget
                                              .viewModel.brandModelList
                                              .indexOf(value)];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      textView1(
                        title: "Category",
                        textSize: 2.0,
                        textAlign: TextAlign.start,
                        color: AppConstants.appColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      categoryTagFilter(),
                      //Price
                      textView1(
                          title: "Price",
                          textSize: 2.0,
                          textAlign: TextAlign.start,
                          color: AppConstants.appColor.blackColor,
                          fontWeight: FontWeight.bold),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: textField1(
                                hint: "Min",
                                controller: widget.viewModel.formMin,
                                margin: EdgeInsets.only(top: 4.0)),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: textField1(
                                hint: "Max",
                                controller: widget.viewModel.formMax,
                                margin: EdgeInsets.only(top: 4.0)),
                          )
                        ],
                      ),
                      skinTypeFilter(),
                      skinConcernFilter(),
                      productTypeFilter(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    //margin: EdgeInsets.only(left: 16.0),
                    child: FlatStatefulButton(
                      text: "RESET",
                      fontSize: SizeConfig.textMultiplier * 1.8,
                      textColor: AppConstants.appColor.whiteColor,
                      padding: EdgeInsets.all(screenSize.width * .02),
                      backgroundColor:
                          AppConstants.appColor.buttonColor3.withOpacity(0.7),
                      buttonHeight: 45,
                      buttonCurve: 0.0,
                      //buttonWidth: 100,
                      onPressedCallback: () {
                        reset();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    //margin: EdgeInsets.only(left: 16.0),
                    child: FlatStatefulButton(
                      text: "DONE",
                      fontSize: SizeConfig.textMultiplier * 1.8,
                      textColor: AppConstants.appColor.whiteColor,
                      padding: EdgeInsets.all(screenSize.width * .02),
                      backgroundColor: AppConstants.appColor.buttonColor3,
                      buttonHeight: 45,
                      buttonCurve: 0.0,
                      //buttonWidth: 100,
                      onPressedCallback: () {
                        search();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
