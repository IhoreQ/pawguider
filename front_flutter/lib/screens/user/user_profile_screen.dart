import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            ElevatedButton(onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove('jwtToken');
              if (context.mounted) {
                context.router.pushAndPopUntil(const LoginRoute(), predicate:  (route) => false);
              }
            }, child: Text('klik')),
          ],
        ),
      ),
    );
  }
}
