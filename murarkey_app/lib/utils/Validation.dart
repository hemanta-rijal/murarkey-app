import 'package:flutter/material.dart';

class Validation{
  static final String regex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final String SUCCESS = "SUCCESS";

  bool emailIsValid(String email) => RegExp(regex).hasMatch(email);

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
      return 'Password is less than 6 chars';
    return SUCCESS;
  }
}