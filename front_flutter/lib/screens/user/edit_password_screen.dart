import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/loading_provider.dart';
import 'package:front_flutter/services/user_service.dart';
import 'package:front_flutter/utilities/validator.dart';
import 'package:front_flutter/widgets/form_field/password_form_field.dart';
import 'package:front_flutter/widgets/submit_button.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import '../../widgets/dialogs/error_dialog.dart';

@RoutePage()
class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {

  late final LoadingProvider loadingProvider;
  final UserService userService = UserService();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _retypedPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadingProvider = context.read<LoadingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Change password"),
          titleTextStyle: AppTextStyle.appBarTitleHeading,
          titleSpacing: 0.0,
          backgroundColor: AppColor.primaryOrange,
          leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => context.router.pop(),
              icon: const Icon(
                FluentSystemIcons.ic_fluent_arrow_left_regular,
                size: iconSize,
                color: Colors.white,
              )),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView(
          children: [
            const Gap(30.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Your password must be at least eight characters and should include a combination of numbers, letters and special characters (!\$@%).',
                    style: AppTextStyle.regularDark,
                  ),
                  const Gap(20.0),
                  PasswordFormField(
                    hintText: 'Current password',
                    controller: _currentPasswordController,
                    validator: (value) {
                      return value != null && value.isNotEmpty ? null : "Enter a correct value";
                    },
                  ),
                  const Gap(20.0),
                  PasswordFormField(
                    hintText: 'New password',
                    controller: _newPasswordController,
                    validator: (value) {
                      return Validator.isPasswordValid(value) ? null : 'Password must contain at least 8 characters, one uppercase letter, one number and a special character';
                    },
                  ),
                  const Gap(20.0),
                  PasswordFormField(
                    hintText: 'Retype new password',
                    controller: _retypedPasswordController,
                    validator: (value) {
                        return Validator.arePasswordsEqual(_newPasswordController.text, value) ? null : 'Passwords do not match';
                    },
                  ),
                ],
              ),
            ),
            const Gap(30.0),
            SubmitButton(
              label: 'Change password',
              onPressed: () => updatePassword()
            ),
            const Gap(30.0),
          ],
        ),
      )
    );
  }

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) {
      loadingProvider.setLoading(true);
      String oldPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;
      bool isChanged = await userService.updatePassword(oldPassword, newPassword);

      if (context.mounted) {
        loadingProvider.setLoading(false);
        if (!isChanged) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                title: 'Password change error',
                content: 'Provided wrong current password.',
              );
            },
          );
        } else {
          context.router.pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                title: 'Updated',
                content: 'Your password has been updated.',
              );
            },
          );
        }
      }
    }
  }
}
