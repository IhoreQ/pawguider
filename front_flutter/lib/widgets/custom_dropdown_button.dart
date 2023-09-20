import 'package:flutter/material.dart';

import '../styles.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.valuesList,
    required this.labelText,
    this.onChanged,
  }) : super(key: key);

  final String dropdownValue;
  final List<String> valuesList;
  final String labelText;
  final void Function(String?)? onChanged;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
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
        style: AppTextStyle.mediumDark,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryOrange)
          ),
          labelText: widget.labelText,
          labelStyle: AppTextStyle.regularLight.copyWith(fontSize: 14.0),
        ),
        onChanged: widget.onChanged,
    );
  }
}