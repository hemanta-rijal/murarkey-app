import 'package:murarkey_app/custom_views/SearchBarWidget.dart';
import 'package:murarkey_app/custom_views/drop_down/DropDownWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditBillingAddressViewModel.dart';
import 'package:murarkey_app/views/search/widgets/SearchItemWidget.dart';

/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

class SearchWidget extends StatefulWidget {
  final List<CategoryModel> categoryModelList;
  final List<BrandModel> brandModelList;

  SearchWidget(
      {Key key,
      @required this.categoryModelList,
      @required this.brandModelList})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState(widget: this);
}

class _SearchWidgetState extends CustomStatefulWidgetState<SearchWidget> {
  final SearchWidget widget;
  EditBillingAddressViewModel viewModel = new EditBillingAddressViewModel();

  _SearchWidgetState({this.widget});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var categoryModelList = Datas.ourServicesList;

    Widget buildWidget() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
                textHint: 'Search by Service or Product',
                onTextChange: (value) {
                  print(value);
                }),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Filter by Brands
                  textView1(
                      title: "Filter by Brands",
                      textSize: 2.0,
                      textAlign: TextAlign.start,
                      color: AppConstants.appColor.blackColor,
                      fontWeight: FontWeight.bold),
                  dropDown1(
                      margin: EdgeInsets.only(top: 4.0),
                      modelList: AccountDatas.countryList,
                      value: viewModel.formCountry,
                      onChange: (value) {
                        setState(() {
                          viewModel.formCountry = AccountDatas.countryList[
                              AccountDatas.countryList.indexOf(value)];
                        });
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  //Filter by Category
                  textView1(
                      title: "Filter by Category",
                      textSize: 2.0,
                      textAlign: TextAlign.start,
                      color: AppConstants.appColor.blackColor,
                      fontWeight: FontWeight.bold),
                  dropDown1(
                      margin: EdgeInsets.only(top: 4.0),
                      modelList: AccountDatas.countryList,
                      value: viewModel.formCountry,
                      onChange: (value) {
                        setState(() {
                          viewModel.formCountry = AccountDatas.countryList[
                              AccountDatas.countryList.indexOf(value)];
                        });
                      }),
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
                            hint: "Max",
                            controller: viewModel.formFirstName,
                            margin: EdgeInsets.only(top: 4.0)),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: textField1(
                            hint: "Min",
                            controller: viewModel.formFirstName,
                            margin: EdgeInsets.only(top: 4.0)),
                      )
                    ],
                  )
                ],
              ),
            ),
            SearchItemWidget(modelList: categoryModelList),
          ],
        ),
      );
    }

    return renderWithAppBar(
        appBarText: "Search Product", childWidget: buildWidget());
  }
}
