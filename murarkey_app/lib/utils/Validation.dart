import 'package:flutter/material.dart';

class Validation{
  //https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number
  //https://stackoverflow.com/questions/64828603/python-regex-for-nepali-numbers
  //https://regex101.com/r/DsaRfI/1

  static final String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final String phoneRegex = r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';

  static final String SUCCESS = "SUCCESS";

  bool emailIsValid(String email) => RegExp(emailRegex).hasMatch(email);

  static String validateUserName(String username, String type) {
    if (username.isEmpty)
      return 'Please enter your username';
    else if (username.length < 4)
      return '${type} should be greater than 4 letters';
    return SUCCESS;
  }

  static String validateEmail(String email) {
    if (email.isEmpty) return 'Please enter your email address';
    final RegExp nameExp = new RegExp(emailRegex);
    if (!nameExp.hasMatch(email)) return 'Invalid email address';
    return SUCCESS;
  }

  static String validatePassword(String password) {
    if (password.isEmpty)
      return 'Please enter your password';
    else if (password.length < 6)
      return 'Password is should be greater than 6 letters';
    return SUCCESS;
  }

  static String validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty)
      return 'Please enter your password';
    else if (password != confirmPassword)
      return 'Password did not matched';
    return SUCCESS;
  }

  static String validatePhoneNo(String value) {
    if (value.isEmpty) return 'Please enter your phone no.';
    final RegExp nameExp = new RegExp(phoneRegex);
    if (!nameExp.hasMatch(value)) return 'Invalid Phone no.';
    return SUCCESS;
  }
}