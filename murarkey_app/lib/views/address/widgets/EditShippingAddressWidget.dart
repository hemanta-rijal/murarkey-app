import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/drop_down/DropDownWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';
import 'package:murarkey_app/repository/models/payment_card_address/PaymentCardAddresModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditBillingAddressViewModel.dart';
import 'package:murarkey_app/views/address/widgets/DropDownCountryWidget.dart';

/**
 * Created by Suman Prasad Neupane on 5/22/2021.
 */

class EditShippingAddressWidget extends StatefulWidget {
  UserModel userModel = GlobalData.userModel;

  EditShippingAddressWidget({Key key}) : super(key: key);

  @override
  _EditShippingAddressWidgetState createState() =>
      _EditShippingAddressWidgetState(userModel);
}

class _EditShippingAddressWidgetState
    extends CustomStatefulWidgetState<EditShippingAddressWidget> {
  EditBillingAddressViewModel viewModel = new EditBillingAddressViewModel();

  _EditShippingAddressWidgetState(UserModel userModel) {
    PaymentCardAddresModel billing_details = userModel.shipment_details;
    if (userModel != null && billing_details != null) {
      viewModel.formCity.text = billing_details.city;
      viewModel.formStateOrZone.text = billing_details.state;
      viewModel.formZipCode.text = billing_details.zip;
      viewModel.formSpecificAddress.text = billing_details.specific_address;

      if (billing_details.specific_address != null &&
          billing_details.specific_address != "") {
        List<dynamic> country = GlobalData.countryListModel
            .where((CountryModel element) =>
                element.name == billing_details.country ? true : false)
            .toList();

        if (country.length > 0) {
          viewModel.formCountry = GlobalData.countryListModel[
              GlobalData.countryListModel.indexOf(country[0])];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget billingAddressForm() {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textView1(
                  title: "Shipping Address",
                  textSize: 2.2,
                  fontWeight: FontWeight.bold),

              //Country / Region drp down
              textView1(
                  title: "Street Address", margin: EdgeInsets.only(top: 16)),
              dropDownCountryWidget(
                  margin: EdgeInsets.only(top: 4.0),
                  modelList: GlobalData.countryListModel,
                  value: viewModel.formCountry,
                  onChange: (value) {
                    setState(() {
                      viewModel.formCountry = GlobalData.countryListModel[
                          GlobalData.countryListModel.indexOf(value)];
                    });
                  }),

              //Town / City
              textView1(title: "Town / City", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formCity,
                  margin: EdgeInsets.only(top: 8.0)),

              //State / Zone drp down
              textView1(
                  title: "State / Zone", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formStateOrZone,
                  margin: EdgeInsets.only(top: 8.0)),

              //Postcode / ZIP (optional)
              textView1(
                  title: "Postcode / ZIP", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formZipCode,
                  keyboardType: TextInputType.number,
                  margin: EdgeInsets.only(top: 8.0)),

              //Specific Address
              textView1(
                  title: "Specific Address", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formSpecificAddress,
                  margin: EdgeInsets.only(top: 8.0)),
            ],
          ),
        ),
      );
    }

    Widget buildView() {
      return Container(
        margin: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          billingAddressForm(),

          SizedBox(
            height: 50,
          ),
        ]),
      );
    }

    floatingWidget() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppConstants.appColor.primaryLightColor3,
                        AppConstants.appColor.primaryColor
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        viewModel.updateShippingAddress(context);
                      },
                      child: Text(
                        "Save Billing Address",
                        style: TextStyle(
                          color: AppConstants.appColor.whiteColor,
                          fontSize: SizeConfig.textMultiplier * 2.0,
                          //fontWeight: setFontWeight(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    return renderWithAppBar(
      appBarText: "Edit Shipping Address",
      showBackbutton: true,
      appBarTextAlignment: MainAxisAlignment.start,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
      floatingWidget: floatingWidget(),
    );
  }
}
