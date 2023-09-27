import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/form_field/custom_icon_form_field.dart';
import 'package:front_flutter/widgets/icon_dropdown_button.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../routes/router.dart';
import '../../utilities/image_getter.dart';
import '../../widgets/submit_button.dart';

@RoutePage()
class RegisterDetailsScreen extends StatefulWidget {
  const RegisterDetailsScreen({super.key});

  @override
  State<RegisterDetailsScreen> createState() => _RegisterDetailsScreenState();
}

class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {
  final _picker = ImagePicker();
  File? image;

  final _phoneController = TextEditingController();
  final List<String> _cities = ['Kraków', 'Warszawa'];
  String? _selectCity;
  final List<String> _genders = ['Male', 'Female'];
  String? _selectedGender;

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
                  Container(
                    child: image == null
                        ? Column(
                            children: [
                              Center(
                                  child: ElevatedButton(
                                onPressed: () =>
                                    ImageGetter.selectPhoto(context, _getImage),
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(25.0),
                                    backgroundColor: AppColor.lightGray,
                                    foregroundColor: Colors.white),
                                child: const Icon(
                                  FluentSystemIcons.ic_fluent_camera_filled,
                                  size: 30.0,
                                  color: AppColor.lightText,
                                ),
                              )),
                              const Gap(10.0),
                              GestureDetector(
                                  onTap: () =>
                                      ImageGetter.selectPhoto(context, _getImage),
                                  child: Text('Add profile picture',
                                      style: AppTextStyle.semiBoldLight))
                            ],
                          )
                        : Column(
                            children: [
                              Center(
                                  child: Stack(children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: [AppShadow.photoShadow]),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.file(
                                          File(image!.path).absolute,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover)),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () => ImageGetter.selectPhoto(
                                            context, _getImage)),
                                  ),
                                ),
                              ])),
                              const Gap(10.0),
                              GestureDetector(
                                  onTap: () =>
                                      ImageGetter.selectPhoto(context, _getImage),
                                  child: Text('Change picture',
                                      style: AppTextStyle.semiBoldOrange)),
                            ],
                          ),
                  ),
                  const Gap(20.0),
                  CustomIconFormField(
                      hintText: 'Phone',
                      controller: _phoneController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_phone_regular,
                        color: AppColor.lightText,
                      )),
                  const Gap(15.0),
                  IconDropdownButton(
                    dropdownValue: _selectedGender,
                    valuesList: _genders,
                    labelText: 'Gender',
                    prefixIcon: const Icon(
                        FluentSystemIcons.ic_fluent_people_team_regular,
                        color: AppColor.lightText),
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
                  ),
                  const Gap(35.0),
                  SubmitButton(
                      label: 'Submit',
                      onPressed: () {
                        // TODO proces rejestracji dodatkowych danych
                        if (_formKey.currentState!.validate()) {
                          print('register');
                          print(_selectedGender);
                          print(_selectCity);
                          context.router.navigate(LoginRoute(onResult: (result) {}));
                        }
                      }
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

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }
}
