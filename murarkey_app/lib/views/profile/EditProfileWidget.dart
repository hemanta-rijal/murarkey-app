import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/app_bar/AppBarWidget.dart';
import 'package:murarkey_app/custom_views/image_picker/ImagePickerWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/custom_views/text_view/TextFieldWidget.dart';
import 'package:murarkey_app/custom_views/text_view/TextviewWidget.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/profile/view_model/EditProfileViewModel.dart';

/**
 * Created by Suman Prasad Neupane on 5/19/2021.
 */

class EditProfileWidget extends StatefulWidget {
  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState
    extends CustomStatefulWidgetState<EditProfileWidget> {
  final EditProfileViewModel viewModel = new EditProfileViewModel();
  final UserModel userModel = GlobalData.userModel;
  var _cardSize = 68.0;
  PickedFile imagePickedFile = null;

  _EditProfileWidgetState() {
    if (userModel != null) {
      viewModel.formEmail.text = userModel.email;
      viewModel.formName.text = userModel.name;
      viewModel.formPhoneNo.text = userModel.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    loadImage(String imgUrl) {
      return Center(
        child: Column(children: <Widget>[
          imgUrl != null
              ? Container(
                  width: _cardSize,
                  height: _cardSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(imgUrl), fit: BoxFit.fill),
                  ),
                )
              : imagePickedFile == null
                  ? svgImageAssert2(
                      imgUrl: "images/ic_profile.svg", size: _cardSize)
                  : Container(
                      width: _cardSize,
                      height: _cardSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: FileImage(File(imagePickedFile.path)),
                            fit: BoxFit.fill),
                      ),
                    ),
        ]),
      );
    }

    Widget userDetailForm() {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkResponse(
                    child: loadImage(userModel.profileImage),
                    onTap: () async {
                      PickedFile p =
                          await ImagePickerWidget.loadFromGallery(context);
                      if (p != null) {
                        setState(() {
                          imagePickedFile = p;
                        });
                      }
                    },
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textView1(
                      title: "User Detail",
                      textSize: 2.2,
                      fontWeight: FontWeight.bold),
                ],
              ),

              //Name
              textView1(title: "Full Name", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formName,
                  margin: EdgeInsets.only(top: 8.0)),

              //Email Address
              textView1(
                  title: "Email Address", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formEmail,
                  margin: EdgeInsets.only(top: 8.0)),

              //Phone No.
              textView1(title: "Phone No.", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formPhoneNo,
                  keyboardType: TextInputType.number,
                  margin: EdgeInsets.only(top: 8.0)),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 1,
                    child: new FlatStatefulButton(
                      text: "Save",
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      textColor: AppConstants.appColor.accentColor,
                      padding: EdgeInsets.all(screenSize.width * .02),
                      backgroundColor: AppConstants.appColor.buttonColor,
                      buttonHeight: 35,
                      buttonCurve: 8.0,
                      onPressedCallback: () {
                        Commons.toastMessage(context, "Saved Successfully.");
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
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget changePassword() {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Change Password
              textView1(
                  title: "Change Password",
                  textSize: 2.2,
                  fontWeight: FontWeight.bold),
              textView1(
                  title: "Current Password", margin: EdgeInsets.only(top: 8)),
              textField1(
                  controller: viewModel.formCurrentPass,
                  margin: EdgeInsets.only(top: 8.0)),

              textView1(
                  title: "New Password", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formNewPass,
                  margin: EdgeInsets.only(top: 8.0)),

              textView1(
                  title: "Confirm Password", margin: EdgeInsets.only(top: 16)),
              textField1(
                  controller: viewModel.formConfirmPass,
                  margin: EdgeInsets.only(top: 8.0)),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 1,
                    child: new FlatStatefulButton(
                      text: "Done",
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      textColor: AppConstants.appColor.accentColor,
                      padding: EdgeInsets.all(screenSize.width * .02),
                      backgroundColor: AppConstants.appColor.buttonColor,
                      buttonHeight: 35,
                      buttonCurve: 8.0,
                      onPressedCallback: () {
                        Commons.toastMessage(
                            context, "Password changed successfully.");
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
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget buildView() {
      return Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userDetailForm(),
            SizedBox(height: 30),
            changePassword(),

            SizedBox(height: 50),

            //Log in
            // new FlatStatefulButton(
            //   text: AppConstants.constants.BUTTON_SAVE_CHANCES,
            //   fontSize: SizeConfig.textMultiplier * 2.0,
            //   textColor: AppConstants.appColor.accentColor,
            //   padding: EdgeInsets.all(screenSize.width * .02),
            //   backgroundColor: AppConstants.appColor.buttonColor,
            //   buttonHeight: 40,
            //   onPressedCallback: () {
            //     Commons.toastMessage(context, "Saved Successfully.");
            //     // String emailValidate = Validation.validateEmail(
            //     //     widget.viewModel.formEmail.text.trim());
            //     // String passwordValid = Validation.validatePassword(
            //     //     widget.viewModel.formPassword.text.trim());
            //     //
            //     // if (emailValidate != Validation.SUCCESS) {
            //     //   Commons.toastMessage(context, emailValidate);
            //     // } else if (passwordValid != Validation.SUCCESS) {
            //     //   Commons.toastMessage(context, passwordValid);
            //     // } else {
            //     //   Commons.toastMessage(context, "Successfully login");
            //     //   NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);
            //     // }
            //   },
            // ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return renderWithAppBar(
        appBarText: "Edit Pofile", childWidget: buildView());
  }
}
