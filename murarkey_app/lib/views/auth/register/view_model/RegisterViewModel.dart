import 'package:murarkey_app/utils/Imports.dart';

class RegisterViewModel {
  final TextEditingController formFirstName = new TextEditingController();
  final TextEditingController formLastName = new TextEditingController();
  final TextEditingController formEmail = new TextEditingController();
  final TextEditingController formPassword = new TextEditingController();
  final TextEditingController formConfirmPassword = new TextEditingController();

  final String formRole = "user";
}