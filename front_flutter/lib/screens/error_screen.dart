import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/widgets/submit_button.dart';
import 'package:gap/gap.dart';

import '../styles.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.errorMessage, required this.retryFunction});

  final String errorMessage;
  final Function() retryFunction;

  @override
  Widget build(BuildContext context) {
    const iconSize = 30.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryOrange,
        leading: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => context.router.pop(),
            icon: const Icon(
              FluentSystemIcons.ic_fluent_arrow_left_regular,
              size: iconSize,
              color: Colors.white,
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FluentSystemIcons.ic_fluent_cloud_offline_regular,
              size: 70,
              color: AppColor.lightText,
            ),
            Text(errorMessage, style: AppTextStyle.mediumDark, textAlign: TextAlign.center,),
            const Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: SubmitButton(label: "Retry", onPressed: retryFunction),
            )
          ],
        ),
      ),
    );
  }
}
