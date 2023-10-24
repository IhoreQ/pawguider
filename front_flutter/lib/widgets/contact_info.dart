import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';
import 'package:gap/gap.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key, required this.icon, required this.content, required this.type});

  final IconData icon;
  final String content;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.backgroundOrange2,
          radius: 20,
          child: Icon(
            icon,
            color: AppColor.primaryOrange,
            size: 25,
          ),
        ),
        const Gap(5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content, style: AppTextStyle.mediumDark,),
            Text(type, style: AppTextStyle.mediumLight.copyWith(fontSize: 12.0)),
          ],
        )
      ],
    );
  }
}
