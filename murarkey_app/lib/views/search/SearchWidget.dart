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

  SearchWidget(
      {Key key,
      @required this.categoryModelList,
      @required this.brandModelList,
      this.categoryModel})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState(widget: this);
}

class _SearchWidgetState extends CustomStatefulWidgetState<SearchWidget> {
  Repository _repository = new Repository();
  final SearchWidget widget;
  SearchViewModel viewModel = new SearchViewModel();
  List<ProductDetailModel> productDetailList = new List<ProductDetailModel>();

  _SearchWidgetState({this.widget}) {
    if (widget.categoryModel != null) {
      viewModel.categoryValue = widget.categoryModel;
    }

    _search();
  }

  @override
  void initState() {
    viewModel.formMin.addListener(() {
      _search();
      setState(() {});
    });
    viewModel.formMax.addListener(() {
      _search();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.formMin.dispose();
    viewModel.formMax.dispose();
    super.dispose();
  }

  _search() {
    Map<String, dynamic> queryParams = new Map();
    if (viewModel.formSearch != null && viewModel.formSearch != "") {
      queryParams["search"] = viewModel.formSearch;
      //print("lower_price = " + viewModel.formMin.text);
    }
    if (viewModel.brandValue != null) {
      queryParams["brand"] = viewModel.brandValue.slug;
    }
    if (viewModel.categoryValue != null) {
      queryParams["category"] = viewModel.categoryValue.slug;
    }
    if (viewModel.formMin.text != null && viewModel.formMin.text != "") {
      queryParams["lower_price"] = viewModel.formMin.text;
      //print("lower_price = " + viewModel.formMin.text);
    }
    if (viewModel.formMax.text != null && viewModel.formMax.text != "") {
      queryParams["upper_price"] = viewModel.formMax.text;
      //print("lower_price = " + viewModel.formMin.text);
    }
    queryParams["per_page"] = "15";
    //TODO Need to work on pagenation ask to dada

    _repository.productRequestApi
        .getProductList(url: ApiUrls.PRODUCT_SEARCH, queryParams: queryParams)
        .then((value) => {
              productDetailList = value,
              this.setState(() {}),
            });
  }

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
                  _search();
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
                                    _search();
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
            productDetailList != null
                ? SearchItemWidget(
                    modelList: productDetailList,
                    onCallback: (ProductDetailModel productDetailModel) {
                      Map<String, dynamic> arguments = new Map();
                      arguments["productDetailModel"] = productDetailModel;
                      NavigateRoute.pushNamedWithArguments(
                          context, NavigateRoute.PRODUCT_DETAIL, arguments);
                    },
                  )
                : Container(),
          ],
        ),
      );
    }

    return renderWithAppBar(
        appBarText: "Search Product", childWidget: buildWidget());
  }
}
