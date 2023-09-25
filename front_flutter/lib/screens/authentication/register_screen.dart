import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/routes/router.dart';

import '../../styles.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  context.router.navigate(LoginRoute(onResult: (result) {}));
                },
                child: Text(
                  'Sign in',
                  style: AppTextStyle.boldOrange,
                )
            )
          ],
        ),
      ),
    );
  }
}
