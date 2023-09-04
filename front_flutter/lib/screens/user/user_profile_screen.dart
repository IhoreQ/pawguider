import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

@RoutePage(name: 'UserProfileRoute')
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FluentSystemIcons.ic_fluent_settings_regular,
                    size: 30,
                    color: AppColor.primaryOrange,
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
