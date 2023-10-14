import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/city_service.dart';
import 'package:front_flutter/services/gender_service.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/utilities/information_dialog.dart';
import 'package:front_flutter/widgets/common_loading_indicator.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/icon_dropdown_button.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_provider.dart';
import '../../providers/register_details_provider.dart';
import '../../widgets/submit_button.dart';

@RoutePage()
class RegisterDetailsScreen extends StatefulWidget {
  const RegisterDetailsScreen({super.key});

  @override
  State<RegisterDetailsScreen> createState() => _RegisterDetailsScreenState();
}

class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {

  final _phoneController = TextEditingController();
  String? _selectCity;
  String? _selectedGender;

  final _genderService = GenderService();
  final _cityService = CityService();
  final _authService = AuthService();

  bool buttonPressed = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
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
                      validator: (value) {
                        return value!.length < 15 ? null : 'Phone number is too long';
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_phone_regular,
                        color: AppColor.lightText,
                      )),
                  const Gap(15.0),
                  FutureBuilder<List<String>>(
                    future: _genderService.getAllGenders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconDropdownButton(
                          dropdownValue: _selectedGender,
                          valuesList: snapshot.data!,
                          labelText: 'Gender',
                          validator: (value) {
                            return value != null ? null : 'Choose a gender';
                          },
                          prefixIcon: const Icon(
                              FluentSystemIcons.ic_fluent_people_team_regular,
                              color: AppColor.lightText),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        );
                      }

                      return SizedBox(
                        height: 48.0,
                        child: snapshot.hasError ?
                        Align(alignment: Alignment.center, child: Text('Unable to retrieve data. A timeout has occurred.', style: AppTextStyle.errorText,))
                            : const CommonLoadingIndicator(color: AppColor.lightGray),
                      );
                    },
                  ),
                  const Gap(15.0),
                  FutureBuilder<List<String>>(
                    future: _cityService.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconDropdownButton(
                          dropdownValue: _selectCity,
                          valuesList: snapshot.data!,
                          validator: (value) {
                            return value != null ? null : 'Choose a city';
                          },
                          labelText: 'City',
                          prefixIcon: const Icon(
                              FluentSystemIcons.ic_fluent_city_regular,
                              color: AppColor.lightText),
                          onChanged: (value) {
                            setState(() {
                              _selectCity = value!;
                            });
                          },
                        );
                      }

                      return SizedBox(
                          height: 48.0,
                          child: snapshot.hasError ?
                          Align(alignment: Alignment.center, child: Text('Unable to retrieve data. A timeout has occurred.', style: AppTextStyle.errorText,))
                          : const CommonLoadingIndicator(color: AppColor.lightGray),
                      );
                    },
                  ),
                  const Gap(35.0),
                  SubmitButton(
                      label: 'Submit',
                      onPressed: buttonPressed ? () {} : register,
                  ),
                  const Gap(10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      var registerProvider = context.read<RegisterDetailsProvider>();
      registerProvider.addAdditionalInfo(_phoneController.text, _selectedGender!, _selectCity!);

      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.setLoading(true);

      dynamic res = await _authService.register(registerProvider.getRegisterDetails());

      if (context.mounted) {
        if (res['error'] == null) {
          loadingProvider.setLoading(false);
          InformationDialog.show(
            context: context,
            title: 'User created',
            content: 'You can login to the application now.',
            onPressed: () {
                context.router.popUntilRoot();
              }
          );
        } else {
          loadingProvider.setLoading(false);
          InformationDialog.show(
            context: context,
            title: 'Connection timed out',
            content: 'Unable to connect to PawGuider server'
          );
        }
      }

      //context.router.navigate(LoginRoute(onResult: (result) {}));
    }
  }
}
