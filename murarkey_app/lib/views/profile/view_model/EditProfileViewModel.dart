import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class EditProfileViewModel {
  final TextEditingController firstName = new TextEditingController();
  final TextEditingController lastName = new TextEditingController();
  final TextEditingController formEmail = new TextEditingController();
  final TextEditingController formPhoneNo = new TextEditingController();
  final TextEditingController formCurrentPass = new TextEditingController();
  final TextEditingController formNewPass = new TextEditingController();
  final TextEditingController formConfirmPass = new TextEditingController();

  var emailVerification = 0;
  var phoneVerification = 0;

  Repository _repository = new Repository();

  Future updateProfile(BuildContext context, state) async {
    String firstNameValidate =
    Validation.validateUserName(firstName.text.trim(), "First name");

    String lastNameValidate =
    Validation.validateUserName(lastName.text.trim(), "Last name");

    String emailValidate = Validation.validateEmail(formEmail.text.trim());

    String phoneNoValidate =
    Validation.validatePhoneNo(formPhoneNo.text.trim());

    if (firstNameValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, firstNameValidate);
    } else if (firstNameValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, lastNameValidate);
    } else if (emailValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, emailValidate);
    } else if (phoneNoValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, phoneNoValidate);
    } else {
      Map<String, dynamic> params = new Map();
      params["first_name"] = firstName.text.trim();
      params["last_name"] = lastName.text.trim();
      params["email"] = formEmail.text.trim();
      params["phone_number"] = formPhoneNo.text.trim();

      await _repository.userApiRequest
          .updateUserProfile(url: ApiUrls.UPDATE_PROFILE, params: params)
          .then((value) {
        if (value["status"] == 200) {
          Commons.toastMessage(context, value["message"]);
          _refreshUserDetails().then((value) {
            return;
          });
        }
      });

      return;
    }
  }

  Future changePassword(BuildContext context, state) async {
    String currentPassValidate =
    Validation.validatePassword(formCurrentPass.text.trim());

    String newPassValidate =
    Validation.validatePassword(formNewPass.text.trim());

    String confirmPassValidate =
    Validation.validatePassword(formConfirmPass.text.trim());

    String validateConfirmPassword = Validation.validateConfirmPassword(
        formNewPass.text.trim(), formConfirmPass.text.trim());

    var status = "0";

    if (currentPassValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, currentPassValidate);
    } else if (newPassValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, newPassValidate);
    } else if (confirmPassValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, confirmPassValidate);
    } else if (validateConfirmPassword != Validation.SUCCESS) {
      Commons.toastMessage(context, validateConfirmPassword);
    } else {
      Map<String, dynamic> params = new Map();
      params["current_password"] = formCurrentPass.text.trim();
      params["newpassword"] = formNewPass.text.trim();
      params["newpassword_confirmation"] = formConfirmPass.text.trim();

      await _repository.userApiRequest
          .changePassword(url: ApiUrls.CHANGE_PASSWORD, params: params)
          .then((value) {
        if (value["status"] == 200) {
          Commons.toastMessage(context, value["message"]);
          status = "${value["status"]}";
        }
      });

      return status;
    }
  }

  Future logout(BuildContext context, state) async {
    await _repository.authApiRequest
        .logout(url: ApiUrls.LOGOUT_URL)
        .then((value) {
      if (value != null) {
        Commons.toastMessage(context, value["message"]);
        _redirectToLogin(context, state);
      } else {
        Commons.toastMessage(context, "Logout successfully");
        _redirectToLogin(context, state);
      }
    });

    return;
  }

  _redirectToLogin(BuildContext context, state) {
    Future.delayed(const Duration(milliseconds: 100), () {
      state.setState(() {
        NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
      });
    });
  }

  Future _refreshUserDetails() async {
    await _repository.userApiRequest
        .getMyDetails(url: ApiUrls.ABOUT_ME)
        .then((value) =>
    {
      if (value != null)
        {
          GlobalData.userModel = value,
          print(GlobalData.userModel.name),
        }
    });
  }
}
