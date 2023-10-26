import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/city_service.dart';
import 'package:front_flutter/services/gender_service.dart';
import 'package:front_flutter/widgets/custom_dropdown_button.dart';
import 'package:front_flutter/widgets/form_field/custom_form_field.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../styles.dart';
import '../../widgets/sized_loading_indicator.dart';

@RoutePage()
class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final UserProvider userProvider;

  final genderService = GenderService();
  final cityService = CityService();

  late String _selectedGender;
  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    User user = userProvider.user!;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _selectedGender = user.gender;
    _selectedCity = user.cityName;
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const Gap(25.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  labelText: "First name",
                  controller: _firstNameController
                ),
                CustomFormField(
                    labelText: "Last name",
                    controller: _lastNameController
                ),
                FutureBuilder<List<String>>(
                  future: genderService.getAllGenders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomDropdownButton(
                        dropdownValue: _selectedGender,
                        valuesList: snapshot.data!,
                        labelText: 'Gender',
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        }
                      );
                    }

                    return const Column(
                      children: [
                        Gap(15.0),
                        SizedLoadingIndicator(color: AppColor.primaryOrange),
                      ],
                    );
                  }
                ),
                FutureBuilder<List<String>>(
                    future: cityService.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomDropdownButton(
                            dropdownValue: _selectedCity,
                            valuesList: snapshot.data!,
                            labelText: 'Gender',
                            onChanged: (value) {
                              setState(() {
                                _selectedCity = value!;
                              });
                            }
                        );
                      }

                      return const Column(
                        children: [
                          Gap(15.0),
                          SizedLoadingIndicator(color: AppColor.primaryOrange),
                        ],
                      );
                    }
                ),
              ],
            ),
          ),
          const Gap(20.0),
          GestureDetector(
            onTap: () => context.router.push(const EditPasswordRoute()),
            child: Text(
              "Change password",
              style: AppTextStyle.mediumOrange,
            ),
          )
        ],
      ),
    );
  }
}
