import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/widgets/contact_info.dart';
import 'package:front_flutter/widgets/custom_vertical_divider.dart';
import 'package:front_flutter/widgets/profile_avatar.dart';
import 'package:front_flutter/widgets/two_elements_column.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../styles.dart';

@RoutePage(name: 'UserProfileRoute')
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: 1.0,
            color: AppColor.primaryOrange
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, _) {
                      return Stack(
                        children: [
                          TopBar(user: userProvider.user!),
                          MainContentPage(user: userProvider.user!),
                          ProfileAvatar(photoUrl: userProvider.user!.photoUrl!)
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Column(
      children: [
        const Gap(10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => context.router.push(const UserEditRoute()),
                    icon: const Icon(
                      FluentSystemIcons.ic_fluent_edit_filled,
                      size: iconSize,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => showAlertDialog(context),
                    icon: const Icon(
                      FluentSystemIcons.ic_fluent_sign_out_filled,
                      size: iconSize,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        )
      ],
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget logOutButton = TextButton(
      style: AppButtonStyle.lightSplashColor,
      onPressed:  () {
        final authService = AuthService();
        authService.logout(context);
      },
      child: const Text("Log Out", style: TextStyle(color: AppColor.darkText)),
    );
    Widget cancelButton = TextButton(
      style: AppButtonStyle.lightSplashColor,
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text("Cancel", style: TextStyle(color: AppColor.darkText),),
    );
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text("Log out of your account?"),
      actions: [
        cancelButton,
        logOutButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MainContentPage extends StatelessWidget {
  const MainContentPage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    const double mainContainerMarginTop = 130.0;
    const double bottomBarHeight = 80.0;

    return Container(
      margin: const EdgeInsets.only(top: mainContainerMarginTop),
      width: deviceWidth,
      constraints: BoxConstraints(
        minHeight: deviceHeight - bottomBarHeight - mainContainerMarginTop,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(75.0),
            Center(
              child: Text(
                '${user.firstName} ${user.lastName}',
                  style: AppTextStyle.heading1.copyWith(fontSize: 25.0),
              ),
            ),
            const Gap(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                TwoElementsColumn(topText: 'Gender', bottomText: user.gender),
                const CustomVerticalDivider(height: 20.0),
                TwoElementsColumn(topText: 'Dogs', bottomText: '${user.dogsCount}'),
                const CustomVerticalDivider(height: 20.0),
                TwoElementsColumn(topText: 'City', bottomText: user.cityName),
              ],
            ),
            const Gap(25.0),
            Text('Contact info',
                style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
            const Gap(10.0),
            ContactInfo(icon: FluentSystemIcons.ic_fluent_mail_filled, content: user.email!, type: 'Email'),
            const Gap(10.0),
            user.phone != null ?
              ContactInfo(icon: FluentSystemIcons.ic_fluent_phone_filled, content: user.phone!, type: 'Mobile') :
              const SizedBox(),

          ],
        ),
      ),
    );
  }
}
