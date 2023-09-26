import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/icon_dropdown_button.dart';
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

  final _phoneController = TextEditingController();
  final List<String> _cities = ['Kraków', 'Warszawa'];
  String? _selectCity;
  final List<String> _genders = ['Male', 'Female'];
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            child: Column(
              children: [
                const Gap(35.0),
                Text(
                  'Additional information',
                  style: AppTextStyle.heading1.copyWith(fontSize: 25.0),
                ),
                const Gap(25.0),
                CustomIconFormField(
                    hintText: 'Phone',
                    controller: _phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      FluentSystemIcons.ic_fluent_phone_regular,
                      color: AppColor.lightText,
                    )
                ),
                const Gap(15.0),
                IconDropdownButton(
                    dropdownValue: _selectedGender,
                    valuesList: _genders,
                    labelText: 'Gender',
                    prefixIcon: const Icon(
                      FluentSystemIcons.ic_fluent_people_community_regular,
                      color: AppColor.lightText
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                ),
                const Gap(15.0),
                IconDropdownButton(
                  dropdownValue: _selectCity,
                  valuesList: _cities,
                  labelText: 'City',
                  prefixIcon: const Icon(
                      FluentSystemIcons.ic_fluent_city_regular,
                      color: AppColor.lightText
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectCity = value!;
                    });
                  },
                ),
                const Gap(35.0),
                SubmitButton(
                    label: 'Submit',
                    onPressed: () {
                      // TODO proces rejestracji dodatkowych danych
                      print('register');
                      print(_selectedGender);
                      //context.router.navigate(LoginRoute(onResult: (result) {}));
                    }
                ),
                const Gap(10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
