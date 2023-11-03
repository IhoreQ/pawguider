import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/places_provider.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/city_service.dart';
import 'package:front_flutter/services/dto/user/user_update_request.dart';
import 'package:front_flutter/services/gender_service.dart';
import 'package:front_flutter/services/user_service.dart';
import 'package:front_flutter/utilities/constants.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';
import 'package:front_flutter/utilities/validator.dart';
import 'package:front_flutter/widgets/custom_dropdown_button.dart';
import 'package:front_flutter/widgets/form_field/custom_form_field.dart';
import 'package:front_flutter/widgets/sized_error_text.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../exceptions/api_error.dart';
import '../../exceptions/result.dart';
import '../../models/user.dart';
import '../../services/image_service.dart';
import '../../styles.dart';
import '../../utilities/image_getter.dart';
import '../../widgets/common_loading_indicator.dart';
import '../../widgets/sized_loading_indicator.dart';

@RoutePage()
class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {

  final _picker = ImagePicker();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final UserProvider userProvider;
  late final PlacesProvider placesProvider;

  final genderService = GenderService();
  final cityService = CityService();
  final imageService = ImageService();
  final userService = UserService();

  late String _selectedGender;
  late String _selectedCity;

  bool _isLoading = false;
  bool _userHasImage = false;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    placesProvider = context.read<PlacesProvider>();
    User user = userProvider.user!;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _phoneController.text = user.phone ?? '';
    _selectedGender = user.gender;
    _selectedCity = user.cityName;
    _userHasImage = user.photoUrl!.split('/').last != Constants.defaultUserImageName;
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
            )
        ),
        actions: [
          !_isLoading ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => update(),
              icon: const Icon(
                FluentSystemIcons.ic_fluent_checkmark_filled,
                size: iconSize,
                color: Colors.white,
              ))
              : Container(
              margin: const EdgeInsets.only(right: 10.0),
              width: 25,
              child: const CommonLoadingIndicator(color: Colors.white)
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const Gap(25.0),
          Column(
            children: [
              Center(
                  child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: [
                                AppShadow.photoShadow
                              ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Consumer<UserProvider>(
                              builder: (context, userProvider, _) {
                                return userProvider.user != null ?
                                  Image.network(
                                    userProvider.user!.photoUrl!,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover
                                  ) :
                                  Container(
                                    color: Colors.white,
                                    width: 80,
                                    height: 80,
                                  );
                              },
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () => ImageGetter.selectPhoto(
                                context,
                                getImage,
                                deleteFunction: _userHasImage == true ? deleteImage : null
                              )
                            ),
                          ),
                        ),
                      ]
                  )
              ),
              const Gap(10.0),
              GestureDetector(
                  onTap: () => ImageGetter.selectPhoto(
                    context,
                    getImage,
                    deleteFunction: _userHasImage == true ? deleteImage : null
                  ),
                  child: Text('Change photo', style: _userHasImage == true ? AppTextStyle.semiBoldOrange : AppTextStyle.semiBoldLight)
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  labelText: "First name",
                  controller: _firstNameController,
                  validator: (value) {
                    return Validator.isNameValid(value) ? null : "Enter correct name";
                  },
                ),
                CustomFormField(
                    labelText: "Last name",
                    controller: _lastNameController,
                    validator: (value) {
                      return Validator.isNameValid(value) ? null : "Enter correct name";
                    },
                ),
                CustomFormField(
                  labelText: "Phone",
                  controller: _phoneController,
                  validator: (value) {
                    return Validator.isPhoneNumberValid(value) ? null : "Enter correct phone number";
                  },
                ),
                FutureBuilder<Result<List<String>, ApiError>>(
                  future: genderService.getAllGenders(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final result = switch (snapshot.data!) {
                        Success(value: final genders) => genders,
                        Failure(error: final error) => error
                      };

                      if (result is List<String>) {
                        final List<String> genders = result;

                        return CustomDropdownButton(
                            dropdownValue: _selectedGender,
                            valuesList: genders,
                            labelText: 'Gender',
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            }
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
                  }
                ),
                FutureBuilder<Result<List<String>, ApiError>>(
                    future: cityService.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = switch (snapshot.data!) {
                          Success(value: final cities) => cities,
                          Failure(error: final error) => error
                        };

                        if (result is List<String>) {
                          final List<String> cities = result;

                          return CustomDropdownButton(
                              dropdownValue: _selectedCity,
                              valuesList: cities,
                              labelText: 'City',
                              onChanged: (value) {
                                setState(() {
                                  _selectedCity = value!;
                                });
                              }
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

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      uploadImage(image);
    }
  }

  Future deleteImage() async {

    String fileName = userProvider.user!.photoUrl!.split('/').last;

    final result = await imageService.deleteImage(fileName);

    final value = switch (result) {
      Success(value: final successCode) => successCode,
      Failure(error: final error) => error
    };

    if (value is! ApiError) {
      final updateResult = await userService.updateUserPhoto(Constants.defaultUserImageName);

      final updateValue = switch (updateResult) {
        Success(value: final successCode) => successCode,
        Failure(error: final error) => error
      };

      if (context.mounted) {
        if (updateValue is! ApiError) {
          userProvider.fetchCurrentUser(context);

          _userHasImage = false;
          setState(() {});
        } else {
          showErrorDialog(context: context, message: updateValue.message);
        }
      }
    } else {
      if(context.mounted) {
        showErrorDialog(context: context, message: value.message);
      }
    }
  }

  Future uploadImage(File? image) async {

    if (_userHasImage) {
      String fileName = userProvider.user!.photoUrl!.split('/').last;

      final result = await imageService.deleteImage(fileName);

      final value = switch (result) {
        Success(value: final successCode) => successCode,
        Failure(error: final error) => error
      };

      if (value is ApiError) {
        if (context.mounted) {
          showErrorDialog(context: context, message: value.message);
        }
        return;
      }
    }

    final result = await imageService.uploadImage(image!);

    final value = switch (result) {
      Success(value: final photoName) => photoName,
      Failure(error: final error) => error
    };

    if (value is String) {
      String photoName = value;
      final updateResult = await userService.updateUserPhoto(photoName);

      final updateValue = switch (updateResult) {
        Success(value: final successCode) => successCode,
        Failure(error: final error) => error
      };

      if (context.mounted) {
        if (updateValue is! ApiError) {
          userProvider.fetchCurrentUser(context);

          _userHasImage = true;
          setState(() {});
        } else {
          showErrorDialog(context: context, message: updateValue.message);
        }
      }
    } else {
      final error = value as ApiError;
      if (context.mounted) {
        showErrorDialog(context: context, message: error.message);
      }
    }
  }

  Future update() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final request = UserUpdateRequest(_firstNameController.text, _lastNameController.text, _selectedGender, _selectedCity, _phoneController.text);
      bool isUpdated = await userService.updateUser(request);

      if (isUpdated) {
        if (context.mounted) {
          await userProvider.fetchCurrentUser(context);
          int cityId = userProvider.user!.cityId;
          placesProvider.fetchPlacesByCityId(cityId);
          if (context.mounted) {
            context.router.pop();
          }
        }
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
