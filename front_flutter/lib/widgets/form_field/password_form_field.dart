import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onChange,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_passwordVisible,
      style: AppTextStyle.mediumDark,
      validator: widget.validator,
      cursorColor: AppColor.primaryOrange,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.lightText)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColor.primaryOrange)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColor.error)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColor.error)),
          hintText: widget.hintText,
          hintStyle: AppTextStyle.mediumLight,
          prefixIcon: const Icon(
            Icons.password_outlined,
            size: 20.0,
            color: AppColor.lightText,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColor.lightText,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )),
      onChanged: widget.onChange,
    );
  }
}
