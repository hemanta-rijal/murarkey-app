import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/drop_down/DropDownWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditBillingAddressViewModel.dart';
import 'package:murarkey_app/views/search/view_model/SearchViewModel.dart';
import 'package:murarkey_app/views/search/widgets/DropDownBrandWidget.dart';
import 'package:murarkey_app/views/search/widgets/DropDownCategoryWidget.dart';
import 'package:murarkey_app/views/search/widgets/SearchItemWidget.dart';

/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

class SearchWidget extends StatefulWidget {
  final List<CategoryModel> categoryModelList;
  final List<BrandModel> brandModelList;
  final CategoryModel categoryModel;
  final BrandModel brandModel;
  final Map<String, dynamic> skinVarientModelMap;
  final String attribute;

  final String slugType;
  final String slug;

  static final String TYPE_CATEGORY_SLUG = "category";
  static final String TYPE_BRAND_SLUG = "brand";

  SearchWidget({
    Key key,
    @required this.categoryModelList,
    @required this.brandModelList,
    this.categoryModel,
    this.brandModel,
    this.skinVarientModelMap,
    this.slug,
    this.slugType,
    this.attribute,
  }) : super(key: key);

  @override
  SearchWidgetState createState() => SearchWidgetState(widget: this);
}

class SearchWidgetState extends CustomStatefulWidgetState<SearchWidget> {
  final SearchWidget widget;
  SearchViewModel viewModel;

  SearchWidgetState({this.widget}) {
    viewModel = new SearchViewModel(this);

    if (widget.slugType != null && widget.slug != null) {
      viewModel.slugType = widget.slugType;
      viewModel.slug = widget.slug;

      if (viewModel.slug != SearchWidget.TYPE_CATEGORY_SLUG) {
        viewModel.categoryValue = widget.categoryModel;
      }
      if (viewModel.slug != SearchWidget.TYPE_BRAND_SLUG) {
        viewModel.brandValue = widget.brandModel;
      }
    }

    if (widget.skinVarientModelMap != null) {
      viewModel.skinVarientModelMap = widget.skinVarientModelMap;
    }

    if (widget.attribute != null) {
      viewModel.attribute = widget.attribute;
    }

    viewModel.search();
    viewModel.callSearchApi();
  }

  @override
  void initState() {
    viewModel.scrollController.addListener(() {
      if (viewModel.scrollController.position.pixels >=
          viewModel.scrollController.position.maxScrollExtent) {
        viewModel.callNextPage();
      }
    });
    viewModel.formMin.addListener(() {
      viewModel.search();
      viewModel.callSearchApi();
      setState(() {});
    });
    viewModel.formMax.addListener(() {
      viewModel.search();
      viewModel.callSearchApi();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.formMin.dispose();
    viewModel.formMax.dispose();
    viewModel.scrollController.dispose();
    super.dispose();
  }

  // _search() {
  //   if (viewModel.formSearch != null && viewModel.formSearch != "") {
  //     viewModel.queryParams["search"] = viewModel.formSearch;
  //     //print("lower_price = " + viewModel.formMin.text);
  //   }
  //   if (viewModel.brandValue != null) {
  //     viewModel.queryParams["brand"] = viewModel.brandValue.slug;
  //   }
  //   if (viewModel.categoryValue != null) {
  //     viewModel.queryParams["category"] = viewModel.categoryValue.slug;
  //   }
  //
  //   if (viewModel.formMin.text != null && viewModel.formMin.text != "") {
  //     viewModel.queryParams["lower_price"] = viewModel.formMin.text;
  //     //print("lower_price = " + viewModel.formMin.text);
  //   }
  //   if (viewModel.formMax.text != null && viewModel.formMax.text != "") {
  //     viewModel.queryParams["upper_price"] = viewModel.formMax.text;
  //     //print("lower_price = " + viewModel.formMin.text);
  //   }
  //   viewModel.queryParams["per_page"] = viewModel.perPageItems.toString();
  //   //TODO Need to work on pagenation ask to dada
  //   viewModel.queryParams["page"] = viewModel.pageNo.toString();
  //
  //   viewModel.callSearchApi();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget buildWidget() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
                textHint: 'Search by Service or Product',
                onTextChange: (value) {
                  print(value);
                  viewModel.formSearch = value;
                  viewModel.search();
                  viewModel.callSearchApi();
                }),
            SizedBox(
              height: 4,
            ),
            Container(
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
                                modelList: widget.brandModelList,
                                value: viewModel.brandValue,
                                onChange: (value) {
                                  setState(() {
                                    viewModel.brandValue = widget
                                            .brandModelList[
                                        widget.brandModelList.indexOf(value)];
                                    viewModel.search();
                                    viewModel.callSearchApi();
                                  });
                                }),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Filter by Category
                            textView1(
                                title: "Category",
                                textSize: 2.0,
                                textAlign: TextAlign.start,
                                color: AppConstants.appColor.blackColor,
                                fontWeight: FontWeight.bold),
                            dropDownCategory(
                                margin: EdgeInsets.only(top: 4.0),
                                modelList: widget.categoryModelList,
                                value: viewModel.categoryValue,
                                onChange: (value) {
                                  setState(() {
                                    viewModel.categoryValue =
                                        widget.categoryModelList[widget
                                            .categoryModelList
                                            .indexOf(value)];

                                    viewModel.search();
                                    viewModel.callSearchApi();
                                  });
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                            controller: viewModel.formMin,
                            margin: EdgeInsets.only(top: 4.0)),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: textField1(
                            hint: "Max",
                            controller: viewModel.formMax,
                            margin: EdgeInsets.only(top: 4.0)),
                      )
                    ],
                  )
                ],
              ),
            ),
            viewModel.productDetailList != null
                ? SearchItemWidget(
                    modelList: viewModel.productDetailList,
                    onCallback: (ProductDetailModel productDetailModel) {
                      Map<String, dynamic> arguments = new Map();
                      arguments["productDetailModel"] = productDetailModel;
                      NavigateRoute.pushNamedWithArguments(
                          context, NavigateRoute.PRODUCT_DETAIL, arguments);
                    },
                    onScrollBottomCallback: (int listSize) {},
                  )
                : Container(),
          ],
        ),
      );
    }

    onBackPress() {
      if (viewModel.skinVarientModelMap != null) {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
        // NavigateRoute.pop(context);
        // NavigateRoute.pop(context);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        onBackPress();
        return true;
      },
      child: renderWithAppBar(
        appBarText: "Search Product",
        bodybackgroundColor: AppConstants.appColor.backgroundColor2,
        scrollController: viewModel.scrollController,
        onBackPress: () {
          onBackPress();
        },
        childWidget: buildWidget(),
      ),
    );
  }
}
