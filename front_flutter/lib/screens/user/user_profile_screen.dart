import 'package:auto_route/annotations.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return Text(userProvider.user?.firstName ?? '');
              },
            ),
            ElevatedButton(onPressed: ()  {
              var user = context.read<UserProvider>();
              user.updateUser();
            }, child: Text('klik')),
          ],
        ),
      ),
    );
  }
}
