import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/models/form/form_item.dart';
import 'package:front_flutter/utilities/validator.dart';

class DogAdditionFormProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  final _name = FormItem(
    labelText: 'Name',
    errorMessage: 'Please enter correct name',
    formatters: [
      FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z]+|\s"),
      ),
    ]
  );
  final _age = FormItem(
      labelText: 'Age',
      errorMessage: 'Please enter correct age',
      keyboardType: TextInputType.number,
      formatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
  );

  final _description = FormItem();

  get name => _name;
  get age => _age;
  get description => _description;

  validateName(String? value) {
    return value != null ? null : _name.errorMessage;
  }

  validateAge(String? value) {
    return value != null && Validator.isAgeValid(value) ? null : _age.errorMessage;
  }

  validateForm() {
    if (_formKey.currentState!.validate()) {
      print('gitówa');
    }
  }
}