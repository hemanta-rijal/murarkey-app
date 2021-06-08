import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 5/20/2021.
 */

class BookAppointmentViewModel{
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

  getCheckboxItems(){

    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }
}