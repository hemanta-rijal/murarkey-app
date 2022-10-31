import 'package:flutter/material.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/repository/models/service_category/ServiceCategoryModel.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';
import 'package:murarkey_app/views/search/pages/ServiceSearchWidget.dart';

class ServiceSearchViewModel {
  Repository _repository = new Repository();
  dynamic state; //ServiceSearchWidgetState or PopularServicesAtHomeWidgetState

  final TextEditingController formMin = new TextEditingController();
  final TextEditingController formMax = new TextEditingController();
  ScrollController scrollController = ScrollController();

  List<ServicesCategoryListsModel> productDetailList = new List<ServicesCategoryListsModel>();
  List<ServiceCategoryModel> categoryModelList = [];
  ServiceCategoryModel categoryValue = null;

  int perPageItems = 15;
  int pageNo = 1;
  Map<String, dynamic> queryParams = new Map();
  String formSearch = "";

  ServiceSearchViewModel(this.state) {}

  void resetAllParameters() {
    categoryValue = null;
    formMin.text = "";
    formMax.text = "";
  }

  Map<String, dynamic> search() {
    productDetailList = new List<ServicesCategoryListsModel>();

    if (formSearch != null && formSearch != "") {
      queryParams["search"] = formSearch;
      //print("lower_price = " + viewModel.formMin.text);
    }
    if (categoryValue != null) {
      queryParams["category"] = categoryValue.slug;
    }

    if (formMin.text != null && formMin.text != "") {
      queryParams["lower_price"] = formMin.text;
      //print("lower_price = " + viewModel.formMin.text);
    }
    if (formMax.text != null && formMax.text != "") {
      queryParams["upper_price"] = formMax.text;
      //print("lower_price = " + viewModel.formMin.text);
    }

    //queryParams["per_page"] = perPageItems.toString();
    //TODO Need to work on pagenation ask to data
    //queryParams["page"] = pageNo.toString();
    print("queryParams------------> ${queryParams}");
    return queryParams;
  }

  callSearchApi() async {
    EasyLoadingView.show(message: 'Loading...');
    List list = await _repository.servicesApiRequest.searchServicesFromCategory(
      url: ApiUrls.SERVICES_SEARCH,
      queryParams: queryParams,
    );
    if (productDetailList.length == 0) {
      productDetailList = list;
    } else {
      list.forEach((element) {
        productDetailList.add(element);
      });
    }
    EasyLoadingView.dismiss();
    state.setState(() {});
  }

  callNextPage() async {
    // int noOfPages = (productDetailList.length / perPageItems).ceil();
    // if (noOfPages > 0) {
    //   // add next pages items
    //   queryParams.update("page", (_) {
    //     pageNo++;
    //     return pageNo.toString();
    //   });
    //   callSearchApi();
    // }
  }
}
