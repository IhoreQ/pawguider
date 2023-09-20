import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/styles.dart';

class CustomFormField extends StatelessWidget {

  const CustomFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.onChange,
    this.keyboardType
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyle.mediumDark,
      inputFormatters: inputFormatters,
      validator: validator,
      cursorColor: AppColor.primaryOrange,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryOrange)
        ),
        labelText: labelText,
        labelStyle: AppTextStyle.regularLight.copyWith(fontSize: 14.0),
      ),
      onChanged: onChange,
    );
  }
}