import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/UnderlinedTextViewWidget.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/AppConstants.dart';
import 'package:murarkey_app/views/search/view_model/ServiceSearchViewModel.dart';
import 'package:murarkey_app/views/search/widgets/SearchServiceItemWidget.dart';

class PopularServicesAtHomeWidget extends StatefulWidget {
  const PopularServicesAtHomeWidget({Key key}) : super(key: key);

  @override
  State<PopularServicesAtHomeWidget> createState() =>
      PopularServicesAtHomeWidgetState();
}

class PopularServicesAtHomeWidgetState
    extends State<PopularServicesAtHomeWidget> {
  ServiceSearchViewModel viewModel;

  PopularServicesAtHomeWidgetState() {
    viewModel = ServiceSearchViewModel(this);
    viewModel.productDetailList = GlobalData.popularServiceCategoryModelList;
    // viewModel.search();
    // viewModel.callSearchApi();
  }

  // @override
  // void initState() {
  //   viewModel.scrollController.addListener(() {
  //     if (viewModel.scrollController.position.pixels >=
  //         viewModel.scrollController.position.maxScrollExtent) {
  //       viewModel.callNextPage();
  //     }
  //   });
  //   viewModel.formMin.addListener(() {
  //     viewModel.search();
  //     viewModel.callSearchApi();
  //     setState(() {});
  //   });
  //   viewModel.formMax.addListener(() {
  //     viewModel.search();
  //     viewModel.callSearchApi();
  //     setState(() {});
  //   });
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   viewModel.formMin.dispose();
  //   viewModel.formMax.dispose();
  //   viewModel.scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
      child: Column(
        children: [
          UnderlinedTextViewWidget(
            title: AppConstants.constants.POPULAR_SERVICE_AT_HOME,
            fontSize: 2.2,
          ),
          SizedBox(height: 16),
          viewModel.productDetailList != null
              ? SearchServiceItemWidget(
                  columnSize: 3,
                  modelList: viewModel.productDetailList,
                  onCallback: (ServicesCategoryListsModel productDetailModel,
                      int position) {
                    Map<String, dynamic> arguments = new Map();
                    arguments["initialPosition"] = position;
                    arguments["modelList"] = viewModel.productDetailList;
                    arguments["appBarTitle"] =
                        viewModel.productDetailList[position].title;
                    NavigateRoute.pushNamedWithArguments(context,
                        NavigateRoute.OUR_SERVICES_ITEM_DETAIL, arguments);
                  },
                  onScrollBottomCallback: (int listSize) {},
                )
              : Container(),
        ],
      ),
    );
  }
}
