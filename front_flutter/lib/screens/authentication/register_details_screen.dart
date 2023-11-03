import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/city_service.dart';
import 'package:front_flutter/services/gender_service.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/icon_dropdown_button.dart';
import 'package:front_flutter/widgets/sized_error_text.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../exceptions/result.dart';
import '../../providers/loading_provider.dart';
import '../../providers/register_details_provider.dart';
import '../../strings.dart';
import '../../utilities/validator.dart';
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
                        return Validator.isPhoneNumberValid(value) ? null : "Enter correct number";
                      },
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_phone_regular,
                        color: AppColor.lightText,
                      )),
                  const Gap(15.0),
                  FutureBuilder<Result<List<String>, ApiError>>(
                    future: _genderService.getAllGenders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = switch (snapshot.data!) {
                          Success(value: final genders) => genders,
                          Failure(error: final error) => error
                        };

                        if (result is List<String>) {
                          final List<String> genders = result;

                          return IconDropdownButton(
                            dropdownValue: _selectedGender,
                            valuesList: genders,
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
                        } else {
                          final error = result as ApiError;
                          return SizedErrorText(message: error.message);
                        }
                      }

                      return const SizedLoadingIndicator(color: AppColor.primaryOrange);
                    },
                  ),
                  const Gap(15.0),
                  FutureBuilder<Result<List<String>, ApiError>>(
                    future: _cityService.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = switch (snapshot.data!) {
                          Success(value: final cities) => cities,
                          Failure(error: final error) => error
                        };

                        if (result is List<String>) {
                          final List<String> cities = result;

                          return IconDropdownButton(
                            dropdownValue: _selectCity,
                            valuesList: cities,
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
                        } else {
                          final error = result as ApiError;
                          return SizedErrorText(message: error.message);
                        }
                      }

                      return const Column(
                        children: [
                          Gap(15.0),
                          SizedLoadingIndicator(color: AppColor.primaryOrange),
                        ],
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

      final result = await _authService.register(registerProvider.getRegisterDetails());

      if (context.mounted) {
        final value = switch (result) {
          Success(value: final success) => success,
          Failure(error: final error) => error
        };

        loadingProvider.setLoading(false);

        if (value is! ApiError) {
          showInformationDialog(
            context: context,
            title: AppStrings.registerSuccessTitle,
            message: AppStrings.registerSuccessBody,
            onPressed: () {
              context.router.popUntilRoot();
            }
          );
        } else {
          showErrorDialog(context: context, message: value.message);
        }
      }
    }
  }
}
