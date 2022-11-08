import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/checkboxes/MultipleCheckboxWidget.dart';
import 'package:murarkey_app/custom_views/drop_down/DropDownWidget.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/custom_views/network/ConnectivityWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/local/AccountDatas.dart';
import 'package:murarkey_app/repository/local/Datas.dart';
import 'package:murarkey_app/repository/models/join_professional/JoinProfessionalModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/address/view_model/EditBillingAddressViewModel.dart';
import 'package:murarkey_app/views/book_appoinment/view_model/BookAppointmentViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 5/22/2021.
 */

class BookAppontmentWidget extends StatefulWidget {
  @override
  _BookAppontmentWidgetState createState() => _BookAppontmentWidgetState();
}

class _BookAppontmentWidgetState
    extends CustomStatefulWidgetState<BookAppontmentWidget> {
  BookAppointmentViewModel viewModel = new BookAppointmentViewModel();
  Repository _repository = new Repository();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.getCheckboxItems();

    validation() async {
      var check = await Commons.checkNetworkConnectivity();
      if (!check) {
        EasyLoading.show(
          status: "",
          indicator: Connectivity2Widget(
            retry: () {
              validation();
            },
            cancel: () {
              EasyLoading.dismiss();
            },
          ),
          maskType: EasyLoadingMaskType.custom,
        );
        return;
      } else {
        if (viewModel.validate(context)) {
          Map<String, dynamic> params = new Map();
          params["full_name"] = viewModel.formFirstName.text.trim() +
              " " +
              viewModel.formLastName.text.trim();
          params["email"] = viewModel.formEmail.text.trim();
          params["phone_number"] = viewModel.formPhone.text.trim();
          params["viber_number"] = viewModel.formViberPhone.text.trim();
          params["preferred_work"] =
              viewModel.values.toString(); //json.encode(viewModel.values);
          params["preferred_location"] = viewModel.formCountry.trim();
          params["about"] = viewModel.formNote.text.trim();

          EasyLoadingView.show(message: 'Loading...');
          await _repository.joinProfessionalApi
              .postJoinProfessional(
                  url: ApiUrls.JOIN_PARLOR_PROFESSION, params: params)
              .then((JoinProfessionalModel value) => {
                    EasyLoadingView.dismiss(),
                    this.setState(() {
                      Commons.toastMessage(context, "Successfully booked.");
                      //NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
                    }),
                  });
        }
      }
    }

    Widget title() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: textView1(
                  title: "INTRODUCING",
                  textAlign: TextAlign.center,
                  textSize: 2.0,
                  fontWeight: FontWeight.bold),
            ),

            // Center(
            //   child: richText1("Murarkey Pro", "\nOwn Your Career With Murarkey")
            // ),
            Center(
              child: textView1(
                  title: "Murarkey Pro",
                  textAlign: TextAlign.center,
                  color: AppConstants.appColor.primaryColor,
                  textSize: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: textView1(
                  title: "Own Your Career With Murarkey",
                  textAlign: TextAlign.center,
                  color: AppConstants.appColor.textColor2,
                  textSize: 1.8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    Widget name() {
      return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppConstants.appColor.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //First Name
            textView1(
              title: "First Name",
              margin: EdgeInsets.only(top: 8),
            ),
            textField1(
                controller: viewModel.formFirstName,
                margin: EdgeInsets.only(top: 8.0)),

            //Last Name
            textView1(title: "Last Name", margin: EdgeInsets.only(top: 16)),
            textField1(
                controller: viewModel.formLastName,
                margin: EdgeInsets.only(top: 8.0)),
          ],
        ),
      );
    }

    Widget joinUsForm() {
      return Container(
        margin: EdgeInsets.all(8),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            margin: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //First Name
                textView1(
                  title: "First Name",
                  margin: EdgeInsets.only(top: 8),
                ),
                textField1(
                    controller: viewModel.formFirstName,
                    margin: EdgeInsets.only(top: 8.0)),

                //Last Name
                textView1(title: "Last Name", margin: EdgeInsets.only(top: 16)),
                textField1(
                    controller: viewModel.formLastName,
                    margin: EdgeInsets.only(top: 8.0)),
                //Preferred Work
                textView1(
                    title: "Preferred Work ", margin: EdgeInsets.only(top: 16)),
                Card(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: multipleCheckbox1(
                      viewModel.values, viewModel.formPerferredWork,
                      (key, value) {
                    setState(() {
                      viewModel.values[key] = value;
                      //viewModel.formPerferredWork =  viewModel.values[key];
                    });
                  }),
                )),
                textView1(
                    title: "You can select multiple options too.",
                    textAlign: TextAlign.center,
                    color: AppConstants.appColor.textColor2,
                    textSize: 1.3,
                    fontWeight: FontWeight.bold),

                //Preferred Location
                textView1(
                    title: "Preferred Location",
                    margin: EdgeInsets.only(top: 16)),
                dropDown1(
                    margin: EdgeInsets.only(top: 8.0),
                    modelList: Datas.bookAnAppointmentLocationList,
                    value: viewModel.formCountry,
                    onChange: (value) {
                      setState(() {
                        viewModel.formCountry = Datas
                                .bookAnAppointmentLocationList[
                            Datas.bookAnAppointmentLocationList.indexOf(value)];
                      });
                    }),
                textView1(
                    title: "You can select the place which is near to you.",
                    textAlign: TextAlign.center,
                    color: AppConstants.appColor.textColor2,
                    textSize: 1.3,
                    fontWeight: FontWeight.bold),

                //Phone
                textView1(
                    title: "Phone number", margin: EdgeInsets.only(top: 16)),
                textField1(
                    controller: viewModel.formPhone,
                    margin: EdgeInsets.only(top: 8.0)),
                textView1(
                    title: "We will contact you in this number.",
                    textAlign: TextAlign.center,
                    color: AppConstants.appColor.textColor2,
                    textSize: 1.3,
                    fontWeight: FontWeight.bold),

                //Phone
                textView1(
                    title: "Viber Phone number",
                    margin: EdgeInsets.only(top: 16)),
                textField1(
                    controller: viewModel.formViberPhone,
                    margin: EdgeInsets.only(top: 8.0)),
                textView1(
                    title: "We will send you important notice on this.",
                    textAlign: TextAlign.center,
                    color: AppConstants.appColor.textColor2,
                    textSize: 1.3,
                    fontWeight: FontWeight.bold),

                //Email Address
                textView1(
                    title: "Email Address", margin: EdgeInsets.only(top: 16)),
                textField1(
                    controller: viewModel.formEmail,
                    margin: EdgeInsets.only(top: 8.0)),

                //Email Address
                textView1(
                    title:
                        "Write something about you and special services that you provide. (For eg. About Education, Training and others)",
                    margin: EdgeInsets.only(top: 16)),
                textField2(
                    controller: viewModel.formNote,
                    margin: EdgeInsets.only(top: 8.0)),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          //name(),
          joinUsForm(),
          SizedBox(
            height: 88,
          ),
        ],
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
                        validation();
                      },
                      child: Text(
                        AppConstants.constants.BUTTON_SUBMIT,
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
      appBarText: AppConstants.constants.BOOK_AN_APPOINTMENT,
      showBackbutton: true,
      appBarTextAlignment: MainAxisAlignment.start,
      bodybackgroundColor: AppConstants.appColor.backgroundColor2,
      childWidget: buildView(),
      floatingWidget: floatingWidget(),
    );
  }
}
