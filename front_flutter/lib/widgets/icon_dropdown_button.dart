import 'package:flutter/material.dart';

import '../styles.dart';

class IconDropdownButton extends StatefulWidget {
  const IconDropdownButton({
    Key? key,
     this.dropdownValue,
    required this.valuesList,
    required this.labelText,
    required this.prefixIcon,
    this.onChanged,
    this.validator
  }) : super(key: key);

  final String? dropdownValue;
  final List<String> valuesList;
  final String labelText;
  final Icon prefixIcon;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<IconDropdownButton> createState() => _IconDropdownButtonState();
}

class _IconDropdownButtonState extends State<IconDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.dropdownValue,
      items: widget.valuesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: const Icon(Icons.keyboard_arrow_right_outlined, color: AppColor.lightText,),
      validator: widget.validator,
      style: AppTextStyle.mediumDark,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                width: 1,
                color: AppColor.lightText
            )
        ),
        prefixIcon: widget.prefixIcon,
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
        hintText: widget.labelText,
        hintStyle: AppTextStyle.mediumLight,
      ),
      onChanged: widget.onChanged,
    );
  }
}