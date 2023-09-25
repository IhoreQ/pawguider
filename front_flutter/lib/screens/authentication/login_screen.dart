import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/form_field/password_form_field.dart';
import 'package:gap/gap.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final Function(bool?) onResult;
  const LoginScreen({super.key, required this.onResult});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                    'assets/images/logo.png',
                  width: 200,
                ),
              ),
              const Gap(35.0),
              CustomIconFormField(
                hintText: 'Email',
                controller: _emailController,
                prefixIcon: const Icon(
                  FluentSystemIcons.ic_fluent_mail_regular,
                  color: AppColor.lightText,
                ),
              ),
              const Gap(15.0),
              PasswordFormField(
                hintText: 'Password',
                controller: _passwordController,
              ),
              const Gap(50.0),
              FilledButton(
                  style: FilledButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.3),
                    backgroundColor: AppColor.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size.fromHeight(50.0),
                  ),
                  onPressed: () {
                    // TODO proces logowania
                  },
                  child: Text(
                    'Sign in',
                    style: AppTextStyle.semiBoldWhite,
                  )
              ),
              const Gap(20.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: AppTextStyle.mediumLight,
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.navigateNamed('/register');
                    },
                    child: Text(
                      'Sign up',
                      style: AppTextStyle.boldOrange,
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
