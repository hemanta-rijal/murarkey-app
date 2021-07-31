import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
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

  Future _refreshUserDetails() async {
    await _repository.userApiRequest
        .getMyDetails(url: ApiUrls.ABOUT_ME)
        .then((value) => {
              if (value != null)
                {
                  GlobalData.userModel = value,
                  print(GlobalData.userModel.name),
                }
            });
  }

// void updatePassword(BuildContext context) async {
//   String firstNameValidate = Validation.validateUserName(
//       firstName.text.trim(), "First name");
//
//   String lastNameValidate = Validation.validateUserName(
//       lastName.text.trim(), "Last name");
//
//   String emailValidate =
//   Validation.validateEmail(formEmail.text.trim());
//
//   String passwordValid = Validation.validatePassword(
//       formCurrentPass.text.trim());
//
//   String confirmPasswordValid = Validation.validateConfirmPassword(
//       formNewPass.text.trim(),
//       formConfirmPass.text.trim());
//
//   if (firstNameValidate != Validation.SUCCESS) {
//     Commons.toastMessage(context, firstNameValidate);
//   } else if (firstNameValidate != Validation.SUCCESS) {
//     Commons.toastMessage(context, lastNameValidate);
//   } else if (emailValidate != Validation.SUCCESS) {
//     Commons.toastMessage(context, emailValidate);
//   } else if (passwordValid != Validation.SUCCESS) {
//     Commons.toastMessage(context, passwordValid);
//   } else if (confirmPasswordValid != Validation.SUCCESS) {
//     Commons.toastMessage(context, confirmPasswordValid);
//   } else {
//     Map<String, dynamic> params = new Map();
//     params["first_name"] = formFirstName.text.trim();
//     params["last_name"] = formLastName.text.trim();
//     params["email"] = formEmail.text.trim();
//     params["password"] = formPassword.text.trim();
//     params["role"] = formRole;
//
//     await _repository.authApiRequest
//         .register(url: ApiUrls.REGISTER_URL, params: params)
//         .then((UserModel value) => {
//       this.setState(() {
//         Commons.toastMessage(context, "Registered Successfully! Please Login.");
//         NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
//       }),
//     });
//   }
// }
}
