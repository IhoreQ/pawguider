import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:gap/gap.dart';

import '../../routes/router.dart';
import '../../widgets/submit_button.dart';

@RoutePage()
class RegisterDetailsScreen extends StatefulWidget {
  const RegisterDetailsScreen({super.key});

  @override
  State<RegisterDetailsScreen> createState() => _RegisterDetailsScreenState();
}

class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final _dateOfBirthController = TextEditingController();
    final _phoneController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const Gap(35.0),
              Text(
                'Additional information',
                style: AppTextStyle.heading1.copyWith(fontSize: 25.0),
              ),
              const Gap(25.0),
              CustomIconFormField(
                  hintText: 'Date of birth',
                  controller: _dateOfBirthController,
                  prefixIcon: const Icon(
                    FluentSystemIcons.ic_fluent_calendar_regular,
                    color: AppColor.lightText,
                  )
              ),
              const Gap(15.0),
              CustomIconFormField(
                  hintText: 'Phone',
                  controller: _phoneController,
                  prefixIcon: const Icon(
                    FluentSystemIcons.ic_fluent_phone_regular,
                    color: AppColor.lightText,
                  )
              ),
              const Gap(15.0),
              CustomIconFormField(
                  hintText: 'Gender',
                  controller: _dateOfBirthController,
                  prefixIcon: const Icon(
                    FluentSystemIcons.ic_fluent_people_team_regular,
                    color: AppColor.lightText,
                  )
              ),
              const Gap(15.0),
              CustomIconFormField(
                  hintText: 'City',
                  controller: _dateOfBirthController,
                  prefixIcon: const Icon(
                    FluentSystemIcons.ic_fluent_city_regular,
                    color: AppColor.lightText,
                  )
              ),
              const Gap(35.0),
              SubmitButton(
                  label: 'Submit',
                  onPressed: () {
                    // TODO proces rejestracji dodatkowych danych
                    print('register');
                    context.router.navigate(LoginRoute(onResult: (result) {}));
                  }
              ),
              const Gap(10.0),
            ],
          ),
        ),
      ),
    );
  }
}
