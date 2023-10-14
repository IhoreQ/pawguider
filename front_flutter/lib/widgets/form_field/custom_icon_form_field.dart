import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/styles.dart';

class CustomIconFormField extends StatelessWidget {

  const CustomIconFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.inputFormatters,
    this.validator,
    this.onChange,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextInputType? keyboardType;
  final Icon prefixIcon;

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
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1,
            color: AppColor.lightText
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColor.primaryOrange)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColor.error)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColor.error)
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.mediumLight,
        prefixIcon: prefixIcon,
      ),
      onChanged: onChange,
    );
  }
}