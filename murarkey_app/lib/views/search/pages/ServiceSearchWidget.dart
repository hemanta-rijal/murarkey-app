import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/views/search/view_model/SearchViewModel.dart';
import 'package:murarkey_app/views/search/view_model/ServiceSearchViewModel.dart';
import 'package:murarkey_app/views/search/widgets/SearchItemWidget.dart';
import 'package:murarkey_app/views/search/widgets/SearchServiceItemWidget.dart';
import 'package:murarkey_app/views/search/widgets/ServiceFilterDialog.dart';

class ServiceSearchWidget extends StatefulWidget {
  const ServiceSearchWidget({Key key}) : super(key: key);

  @override
  ServiceSearchWidgetState createState() => ServiceSearchWidgetState();
}

class ServiceSearchWidgetState
    extends CustomStatefulWidgetState<ServiceSearchWidget> {
  ServiceSearchViewModel viewModel;
  double searchBarHeight = 48;

  ServiceSearchWidgetState() {
    viewModel = ServiceSearchViewModel(this);
    viewModel.categoryModelList = GlobalData.serviceCategoryModelList;
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

  void openFilterDialog() {
    ServiceFilterDialog(
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

  Widget searchItemWidget() {
    if (viewModel.productDetailList != null) {
      return SearchServiceItemWidget(
        columnSize: 2,
        modelList: viewModel.productDetailList,
        onCallback:
            (ServicesCategoryListsModel productDetailModel, int position) {
          Map<String, dynamic> arguments = new Map();
          arguments["initialPosition"] = position;
          arguments["modelList"] = viewModel.productDetailList;
          arguments["appBarTitle"] =
              viewModel.productDetailList[position].title;
          NavigateRoute.pushNamedWithArguments(
            context,
            NavigateRoute.OUR_SERVICES_ITEM_DETAIL,
            arguments,
          );
        },
        onScrollBottomCallback: (int listSize) {},
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    onBackPress() {
      NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
    }

    Widget buildWidget() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: SearchBarWidget(
                    textHint: 'Search by Service',
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
            searchItemWidget(),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        //onBackPress();
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
