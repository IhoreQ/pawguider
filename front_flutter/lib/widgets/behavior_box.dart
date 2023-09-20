import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

class BehaviorBox extends StatelessWidget {
  const BehaviorBox({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(width: 2.0, color: AppColor.primaryOrange),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
      child: Text(
        label,
        style: AppTextStyle.mediumOrange.copyWith(fontSize: 14.0)
      ),
    );
  }
}