import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/drop_down/DropDownWidget.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
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
import 'package:murarkey_app/views/search/widgets/ProductFilterDilaog.dart';
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
  double searchBarHeight = 48;

  SearchWidgetState({this.widget}) {
    viewModel = new SearchViewModel(this);
    viewModel.categoryModelList = widget.categoryModelList;
    viewModel.brandModelList = widget.brandModelList;

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.formMin.dispose();
    viewModel.formMax.dispose();
    viewModel.scrollController.dispose();
    super.dispose();
  }

  void openFilterDialog() {
    ProductFilterDilaog(
      context: context,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 100,
      viewModel: viewModel,
    );
  }

  Widget filterIcon() {
    return InkWell(
      onTap: () {
        openFilterDialog();
      },
      child: Container(
        height: searchBarHeight,
        color: AppConstants.appColor.primaryColor,
        child: Center(
          child: Icon(
            Icons.filter_list_rounded,
            color: AppConstants.appColor.whiteColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget tabViewText({
      String title,
      Color textColor,
    }) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.normal,
            fontSize: SizeConfig.textMultiplier * 2.4,
          ),
        ),
      );
    }

    Widget buildWidget() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppConstants.appColor.primaryColor,
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: tabViewText(
                      title: "Product",
                      textColor: AppConstants.appColor.accentColor,
                    ),
                  ),
                  Container(
                    width: 0.5,
                    color: AppConstants.appColor.greyColor,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkResponse(
                      onTap: () {
                        NavigateRoute.pushNamed(
                          context,
                          NavigateRoute.SERVICE_SEARCH,
                        );
                      },
                      child: tabViewText(
                        title: "Service",
                        textColor: AppConstants.appColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: SearchBarWidget(
                    textHint: 'Search by Product',
                    height: searchBarHeight,
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 4.0,
                      top: 6.0,
                      bottom: 6.0,
                    ),
                    onTextChange: (value) {
                      print(value);
                      viewModel.formSearch = value;
                      viewModel.search();
                      viewModel.callSearchApi();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: filterIcon(),
                ),
              ],
            ),
            SizedBox(
              height: 4,
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
      }
    }

    if (!viewModel.hasNetworkConnectivity) {
      //show dialog here
      print(
          "viewModel.hasNetworkConnectivity===> ${viewModel.hasNetworkConnectivity}");

      EasyLoading.show(
        status: "",
        indicator: ConnectivityWidget(
          retry: () {
            viewModel.search();
            viewModel.callSearchApi();
            EasyLoading.dismiss();
          },
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        onBackPress();
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
        return true;
      },
      child: renderWithAppBar(
        appBarText: "Search",
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
