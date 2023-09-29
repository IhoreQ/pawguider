import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/providers/loading_provider.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/utilities/validator.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/form_field/password_form_field.dart';
import 'package:front_flutter/widgets/submit_button.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final Function(bool?) onResult;
  const LoginScreen({super.key, required this.onResult});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
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
                      validator: (value) {
                        return Validator.isEmailValid(value) ? null : 'Enter correct email';
                      },
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_mail_regular,
                        color: AppColor.lightText,
                      ),
                    ),
                    const Gap(15.0),
                    PasswordFormField(
                      hintText: 'Password',
                      validator: (value) {
                        return value!.isNotEmpty ? null : 'Enter the password';
                      },
                      controller: _passwordController,
                    ),
                    const Gap(50.0),
                    SubmitButton(
                      label: 'Sign in',
                      onPressed: login,
                    ),
                    const Gap(10.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: AppTextStyle.mediumLight,
                        ),
                        TextButton(
                          style: AppButtonStyle.orangeSplashColor,
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
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.setLoading(true);

      dynamic res = await _authService.login(_emailController.text, _passwordController.text);

      if (res['ErrorCode'] == null) {
        String jwtToken = res['jwtToken'];

        if (jwtToken.isNotEmpty) {
          // TODO dodanie do sharedpreferences tokena
          final SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString('jwtToken', jwtToken);
          // TODO pobranie info o użytkowniku

          loadingProvider.setLoading(false);
          widget.onResult.call(true);
        }
        else {
          // TODO wyświetlenie błędu
          print('Wrong data');
        }
      }
      else {
        print('Error');
      }
    }
  }
}
