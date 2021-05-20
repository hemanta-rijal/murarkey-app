import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditAddressViewModel.dart';
import 'package:murarkey_app/views/profile/view_model/EditProfileViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class EditAddressWidget extends StatefulWidget {
  @override
  _EditAddressWidgetState createState() => _EditAddressWidgetState();
}

class _EditAddressWidgetState
    extends CustomStatefulWidgetState<EditAddressWidget> {
  EditAddressViewModel viewModel = new EditAddressViewModel();

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
                  title: "Billing Address",
                  textSize: 2.2,
                  fontWeight: FontWeight.bold),
              //First Name
              textView1(title: "First Name", margin: EdgeInsets.only(top: 8)),
              textField1(
                  controller: viewModel.formFirstName,
                  margin: EdgeInsets.only(top: 8.0)),

              //Last Name
              textView1(title: "Last Name", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formLastName,
                  margin: EdgeInsets.only(top: 8.0)),

              //Country / Region drp down

              //Street address
              textView1(
                  title: "Street Address", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formStreetAddress,
                  margin: EdgeInsets.only(top: 8.0)),

              //Town / City
              textView1(title: "Town / City", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formCity,
                  margin: EdgeInsets.only(top: 8.0)),

              //State / Zone drp down

              //Postcode / ZIP (optional)
              textView1(
                  title: "Postcode / ZIP (optional)",
                  margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formZipCode,
                  margin: EdgeInsets.only(top: 8.0)),

              //Phone
              textView1(title: "Phone", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formPhone,
                  margin: EdgeInsets.only(top: 8.0)),

              //Email Address
              textView1(
                  title: "Email Address", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formEmail,
                  margin: EdgeInsets.only(top: 8.0)),
            ],
          ),
        ),
      );
    }

    Widget buildView() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        billingAddressForm(),

        SizedBox(
          height: 50,
        ),

        //Log in
        new FlatStatefulButton(
          text: AppConstants.constants.BUTTON_SAVE_ADDRESS,
          fontSize: SizeConfig.textMultiplier * 2.0,
          textColor: AppConstants.appColor.accentColor,
          padding: EdgeInsets.all(screenSize.width * .02),
          backgroundColor: AppConstants.appColor.buttonColor,
          buttonHeight: 40,
          onPressedCallback: () {
            Commons.toastMessage(context, "Saved Address Successfully.");
            // String emailValidate = Validation.validateEmail(
            //     widget.viewModel.formEmail.text.trim());
            // String passwordValid = Validation.validatePassword(
            //     widget.viewModel.formPassword.text.trim());
            //
            // if (emailValidate != Validation.SUCCESS) {
            //   Commons.toastMessage(context, emailValidate);
            // } else if (passwordValid != Validation.SUCCESS) {
            //   Commons.toastMessage(context, passwordValid);
            // } else {
            //   Commons.toastMessage(context, "Successfully login");
            //   NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
            // }
          },
        ),
        SizedBox(
          height: 20,
        ),
      ]);
    }

    return renderWithAppBar(
        appBarText: "Edit Billing Address", childWidget: buildView());
  }
}
