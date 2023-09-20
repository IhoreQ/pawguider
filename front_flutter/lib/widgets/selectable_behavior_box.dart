import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

class SelectableBehaviorBox extends StatefulWidget {
  const SelectableBehaviorBox({Key? key, required this.label, required this.onSelected}) : super(key: key);

  final String label;
  final ValueChanged<bool> onSelected;

  @override
  State<SelectableBehaviorBox> createState() => _BehaviorBoxState();
}

class _BehaviorBoxState extends State<SelectableBehaviorBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      splashColor: isSelected ? AppColor.lightGray : AppColor.backgroundOrange2,
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelected(isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(width: 2.0, color: isSelected ? AppColor.primaryOrange : AppColor.lightText),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        child: Text(
          widget.label,
          style: isSelected ? AppTextStyle.mediumOrange.copyWith(fontSize: 14.0) : AppTextStyle.mediumLight.copyWith(fontSize: 14.0),
        ),
      ),
    );
  }
}