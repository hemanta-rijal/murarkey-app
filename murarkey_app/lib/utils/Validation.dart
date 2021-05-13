import 'package:flutter/material.dart';

class Validation{
  static final String regex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final String SUCCESS = "SUCCESS";

  bool emailIsValid(String email) => RegExp(regex).hasMatch(email);

  static String validateUserName(String username) {
    if (username.isEmpty)
      return 'Please enter your username';
    else if (username.length < 4)
      return 'Usernamee should be greater than 4 letters';
    return SUCCESS;
  }

  static String validateEmail(String email) {
    if (email.isEmpty) return 'Please enter your email address';
    final RegExp nameExp = new RegExp(regex);
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
}