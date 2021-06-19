import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class BookAppointmentViewModel {
  final TextEditingController formFirstName = new TextEditingController();
  final TextEditingController formLastName = new TextEditingController();
  final TextEditingController formStreetAddress = new TextEditingController();
  final TextEditingController formPhone = new TextEditingController();
  final TextEditingController formViberPhone = new TextEditingController();
  final TextEditingController formEmail = new TextEditingController();
  final TextEditingController formNote = new TextEditingController();

  String formCountry;
  String formStateOrZone;
  String formPerferredWork;

  Map<String, bool> values = {
    'Parlour Services for Women': false,
    'Makeup': false,
    'Hairstyling': false,
    'Nail Extension/ Nail Art': false,
    'Bridal Services': false,
    'Mehendi': false,
    'Salon Services for Men': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  bool validate(BuildContext context) {
    String firstNameValidate =
        Validation.validateUserName(formFirstName.text.trim(), "First name");

    String lastNameValidate =
        Validation.validateUserName(formLastName.text.trim(), "Last name");

    String emailValidate = Validation.validateEmail(formEmail.text.trim());

    if (firstNameValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, firstNameValidate);
      return false;
    } else if (firstNameValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, lastNameValidate);
      return false;
    } else if (formCountry == null || formCountry == "") {
      Commons.toastMessage(context, "Please choose location");
      return false;
    } else if (formPhone.text == null || formPhone.text == "") {
      Commons.toastMessage(context, "Please enter your phone no.");
      return false;
    } else if (emailValidate != Validation.SUCCESS) {
      Commons.toastMessage(context, emailValidate);
      return false;
    } else if (formNote.text == null || formNote.text == "") {
      Commons.toastMessage(context, "Please write something about you");
      return false;
    } else {
      return true;
    }
  }
}
