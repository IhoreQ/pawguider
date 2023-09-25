import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/form_field/password_form_field.dart';
import 'package:front_flutter/widgets/submit_button.dart';
import 'package:gap/gap.dart';

import '../../styles.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypedPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryOrange,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
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
                      hintText: 'First Name',
                      controller: _firstNameController,
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_contact_card_regular,
                        color: AppColor.lightText,
                      )
                  ),
                  const Gap(10.0),
                  CustomIconFormField(
                      hintText: 'Last Name',
                      controller: _lastNameController,
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_contact_card_regular,
                        color: AppColor.lightText,
                      )
                  ),
                  const Gap(10.0),
                  CustomIconFormField(
                      hintText: 'Email',
                      controller: _emailController,
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_mail_regular,
                        color: AppColor.lightText,
                      )
                  ),
                  const Gap(10.0),
                  PasswordFormField(
                      hintText: 'Password',
                      controller: _passwordController
                  ),
                  const Gap(10.0),
                  PasswordFormField(
                      hintText: 'Retype password',
                      controller: _retypedPasswordController
                  ),
                  const Gap(50.0),
                  SubmitButton(
                      label: 'Sign up',
                      onPressed: () {
                        // TODO proces rejestracji
                        print('register');
                        context.router.navigate(const RegisterDetailsRoute());
                      }
                  ),
                  const Gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: AppTextStyle.mediumLight,
                      ),
                      TextButton(
                          onPressed: () {
                            context.router.navigate(LoginRoute(onResult: (result) {}));
                          },
                          style: AppButtonStyle.orangeSplashColor,
                          child: Text(
                            'Sign in',
                            style: AppTextStyle.boldOrange,
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
