import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

class CustomIconFormField extends StatelessWidget {

  const CustomIconFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.validator,
    this.onChange,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextInputType? keyboardType;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyle.mediumDark,
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
        hintText: hintText,
        hintStyle: AppTextStyle.mediumLight,
        prefixIcon: prefixIcon,
      ),
      onChanged: onChange,
    );
  }
}