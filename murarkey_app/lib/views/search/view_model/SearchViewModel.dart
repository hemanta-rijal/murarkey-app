import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';

/**
 * Created by Suman Prasad Neupane on 6/19/2021.
 */

class SearchViewModel {
  Repository _repository = new Repository();
  SearchWidgetState state;

  final TextEditingController formMin = new TextEditingController();
  final TextEditingController formMax = new TextEditingController();
  ScrollController scrollController = ScrollController();

  String formSearch = "";
  BrandModel brandValue = null;
  CategoryModel categoryValue = null;
  String slugType = null;
  String slug = null;
  Map<String, dynamic> skinVarientModelMap;
  String attribute = null;

  int perPageItems = 15;
  int pageNo = 1;
  Map<String, dynamic> queryParams = new Map();

  List<ProductDetailModel> productDetailList = new List<ProductDetailModel>();

  SearchViewModel(this.state) {}

  Map<String, dynamic> search() {
    productDetailList = new List<ProductDetailModel>();

    if (formSearch != null && formSearch != "") {
      queryParams["search"] = formSearch;
      //print("lower_price = " + viewModel.formMin.text);
    }
    if (brandValue != null) {
      queryParams["brand"] = brandValue.slug;
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

    if (skinVarientModelMap != null) {
      skinVarientModelMap.forEach((key, value) {
        queryParams["${key}"] = value;
      });
    }

    if (attribute != null) {
      queryParams["attribute"] = attribute;
    }

    queryParams["per_page"] = perPageItems.toString();

    //TODO Need to work on pagenation ask to dada
    queryParams["page"] = pageNo.toString();
    return queryParams;
  }

  callSearchApi() async {
    List list = await _repository.productRequestApi.getProductList(
      url: ApiUrls.PRODUCT_SEARCH,
      queryParams: queryParams,
    );
    if (productDetailList.length == 0) {
      productDetailList = list;
    } else {
      list.forEach((element) {
        productDetailList.add(element);
      });
    }
    state.setState(() {});
  }

  callNextPage() async {
    int noOfPages = (productDetailList.length / perPageItems).ceil();
    if (noOfPages > 0) {
      // add next pages items
      queryParams.update("page", (_) {
        pageNo++;
        return pageNo.toString();
      });
      callSearchApi();
    }
  }
}
