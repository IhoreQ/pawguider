import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_flutter/utilities/extensions.dart';

class RegisterDetailsProvider extends ChangeNotifier {
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _password;
  String? _city;
  String? _gender;
  String _phone = '';

  void addBasicInfo(String firstName, String lastName, String email, String password) {
    _firstName = firstName.capitalize();
    _lastName = lastName.capitalize();
    _email = email;
    _password = password;
  }

  void addAdditionalInfo(String phone, String gender, String city) {
    _phone = phone;
    _gender = gender;
    _city = city;
  }

  Map<String, dynamic> getRegisterDetails() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'password': _password,
      'phone': _phone,
      'gender': _gender,
      'city': _city,
    };
  }
}