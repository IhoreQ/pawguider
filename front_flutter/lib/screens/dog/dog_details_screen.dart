import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/providers/user_dogs_provider.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/services/dto/dog/dog_addition_request.dart';
import 'package:front_flutter/services/image_service.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';
import 'package:front_flutter/utilities/extensions.dart';
import 'package:front_flutter/utilities/image_getter.dart';
import 'package:front_flutter/utilities/validator.dart';
import 'package:front_flutter/widgets/custom_dropdown_button.dart';
import 'package:front_flutter/widgets/form_field/custom_form_field.dart';
import 'package:front_flutter/widgets/selectable_behavior_box.dart';
import 'package:front_flutter/widgets/sized_error_text.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../models/dog/behavior.dart';
import '../../models/dog/breed.dart';
import '../../models/dog/dog.dart';
import '../../services/dto/dog/dog_update_request.dart';
import '../../widgets/common_loading_indicator.dart';

@RoutePage()
class DogDetailsScreen extends StatefulWidget {
  const DogDetailsScreen({super.key, this.dog, required this.onComplete});
  final VoidCallback onComplete;
  final Dog? dog;

  @override
  State<DogDetailsScreen> createState() => _DogDetailsScreenState();
}

class _DogDetailsScreenState extends State<DogDetailsScreen> {

  final _picker = ImagePicker();
  File? image;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _genders = <String>['Male', 'Female'];

  Breed? _selectedBreed;
  late String _selectedGender = _genders.first;
  List<Behavior> _selectedBehaviors = [];

  final int _behaviorsMinCount = 3;
  bool _minBehaviorCountSelected = true;
  bool _imageAdded = true;
  late bool _imageUpdated;

  final _formKey = GlobalKey<FormState>();

  final DogService dogService = DogService();
  final ImageService imageService = ImageService();

  late final UserDogsProvider userDogsProvider;

  bool _isLoading = false;
  bool _isDeletionLoading = false;

  @override
  void initState() {
    super.initState();
    userDogsProvider = context.read<UserDogsProvider>();

    if (widget.dog != null) {
      _nameController.text = widget.dog!.name;
      _ageController.text = '${widget.dog!.age}';
      _descriptionController.text = widget.dog!.description!;
      _selectedGender = widget.dog!.gender!;
      _selectedBehaviors = Dog.clone(widget.dog!).behaviors!;
      _imageUpdated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.dog != null ? "Edit a dog" : "Add a dog"),
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
        actions: [
          !_isLoading ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => widget.dog != null ? updateDog() : addDog(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(25.0),
                Container(
                  child: image == null && widget.dog == null ?
                  Column(
                    children: [
                      Center(
                          child: ElevatedButton(
                            onPressed: () => ImageGetter.selectPhoto(context, _getImage),
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(25.0),
                                backgroundColor: AppColor.lightGray,
                                foregroundColor: Colors.white
                            ),
                            child: const Icon(
                              FluentSystemIcons.ic_fluent_camera_filled,
                              size: 30.0,
                              color: AppColor.lightText,
                            ),
                          )
                      ),
                      const Gap(10.0),
                      GestureDetector(
                          onTap: () => ImageGetter.selectPhoto(context, _getImage),
                          child: Text('Add dog photo', style: _imageAdded ? AppTextStyle.semiBoldLight : AppTextStyle.errorText.copyWith(fontSize: 16.0))
                      )
                    ],
                  ) :
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
                                    child: image != null ?
                                      Image.file(
                                        File(image!.path).absolute,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover
                                      ) :
                                      Image.network(
                                        widget.dog!.photoUrl,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover
                                      ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () => ImageGetter.selectPhoto(context, _getImage)),
                                  ),
                                ),
                              ]
                          )
                      ),
                      const Gap(10.0),
                      GestureDetector(
                          onTap: () => ImageGetter.selectPhoto(context, _getImage),
                          child: Text('Change photo', style: AppTextStyle.semiBoldOrange)
                      ),
                    ],
                  ),
                ),
                const Gap(20.0),
                CustomFormField(
                  labelText: 'Name',
                  controller: _nameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-ZŁłĘęÓóŚśĄąŻżŹźĆćŃń]+|\s"),
                    ),
                  ],
                  validator: (value) {
                    return Validator.isDogNameValid(value) ? null : 'Enter correct name';
                  },
                ),
                FutureBuilder<Result<List<Breed>, ApiError>>(
                  future: dogService.getBreeds(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final result = switch (snapshot.data!) {
                        Success(value: final breeds) => breeds,
                        Failure(error: final error) => error
                      };

                      if (result is List<Breed>) {
                        final List<Breed> breeds = result;
                        _selectedBreed ??= widget.dog != null
                            ? breeds.firstWhere((element) => element.name == widget.dog!.breed)
                            : breeds.first;

                        return DropdownButtonFormField(
                            value: _selectedBreed?.name,
                            items: breeds.map<DropdownMenuItem<String>>((Breed value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name),
                              );
                            }).toList(),
                            icon: const Icon(Icons.keyboard_arrow_right_outlined, color: AppColor.lightText,),
                            style: AppTextStyle.mediumDark,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.primaryOrange)
                              ),
                              labelText: 'Breed',
                              labelStyle: AppTextStyle.regularLight.copyWith(fontSize: 14.0),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedBreed = breeds.firstWhere((breed) => breed.name == value);
                              });
                            }
                        );
                      } else {
                        final error = result as ApiError;
                        return Column(
                          children: [
                            const Gap(20.0),
                            SizedErrorText(message: error.message),
                          ],
                        );
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
                CustomFormField(
                  labelText: 'Age',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) => Validator.isAgeValid(value) ? null : 'Enter correct age',
                ),
                CustomDropdownButton(
                  dropdownValue: _selectedGender,
                  valuesList: _genders,
                  labelText: 'Gender',
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                const Gap(20.0),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Traits and behavior',
                      style: AppTextStyle.heading2.copyWith(fontSize: 20.0),
                    )
                ),
                !_minBehaviorCountSelected ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'You have to select at least $_behaviorsMinCount traits',
                      style: AppTextStyle.errorText,
                    )
                ) : const SizedBox(),
                const Gap(10.0),
                FutureBuilder<Result<List<Behavior>, ApiError>>(
                  future: dogService.getBehaviors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final result = switch(snapshot.data!) {
                        Success(value: final behaviors) => behaviors,
                        Failure(error: final error) => error
                      };

                      if (result is List<Behavior>) {
                        final List<Behavior> behaviors = result;
                        return Wrap(
                          spacing: 5.0,
                          runSpacing: 10.0,
                          children: behaviors.map((behavior) {
                            final isBehaviorSelected = _selectedBehaviors.any((
                                selectedBehavior) =>
                            selectedBehavior.id == behavior.id);
                            return SelectableBehaviorBox(
                              label: behavior.name,
                              initValue: isBehaviorSelected,
                              onSelected: (isSelected) {
                                if (isSelected) {
                                  _selectedBehaviors.add(behavior);
                                } else {
                                  _selectedBehaviors.removeWhere((
                                      selectedBehavior) =>
                                  selectedBehavior.id == behavior.id);
                                }
                              },
                            );
                          }).toList(),
                        );

                      } else {
                        final error = result as ApiError;
                        return SizedErrorText(message: error.message);
                      }
                    }
                    return const SizedLoadingIndicator(color: AppColor.primaryOrange);
                  }
                ),
                const Gap(20.0),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'About dog',
                      style: AppTextStyle.heading2.copyWith(fontSize: 20.0),
                    )
                ),
                const Gap(10.0),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  minLines: 6,
                  cursorColor: AppColor.primaryOrange,
                  style: AppTextStyle.mediumDark.copyWith(fontSize: 14.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5.0),
                    hintText: 'Write something about your dog...',
                    hintStyle: AppTextStyle.mediumLight.copyWith(fontSize: 14),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryOrange,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const Gap(20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: widget.dog != null ? OutlinedButton(
                    onPressed: () => showAlertDialog(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 2.0,
                        color: AppColor.primaryOrange
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FluentSystemIcons.ic_fluent_delete_regular,
                          color: AppColor.primaryOrange,
                          size: 20.0,
                        ),
                        const Gap(5.0),
                        Text(
                          'Delete dog',
                          style: AppTextStyle.mediumOrange,
                        )
                      ],
                    )
                  ) : null,
                ),
                const Gap(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget deleteButton = TextButton(
      style: AppButtonStyle.lightSplashColor,
      child: !_isDeletionLoading ?
      Text("Delete", style: AppTextStyle.mediumOrange)
      : const SizedBox(width: 25.0, child: CommonLoadingIndicator(color: AppColor.primaryOrange)),
      onPressed:  () {
        deleteDog();
      },
    );
    Widget cancelButton = TextButton(
      style: AppButtonStyle.lightSplashColor,
      child: Text("Cancel", style: AppTextStyle.mediumOrange,),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text("Delete your dog", style: AppTextStyle.semiBoldDark.copyWith(fontSize: 20.0)),
      content: Text("Are you sure you want to delete this dog?", style: AppTextStyle.mediumLight,),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future deleteDog() async {
    _isDeletionLoading = true;
    final response = await dogService.deleteDog(widget.dog!.id);

    if (context.mounted) {
      final value = switch (response) {
        Success(value: final successCode) => successCode,
        Failure(error: final error) => error
      };

      _isDeletionLoading = false;
      if (value is! ApiError) {
        userDogsProvider.fetchUserDogs(context);
        Navigator.of(context, rootNavigator: true).pop();
        context.router.popUntilRoot();
      } else {
        showErrorDialog(context: context, message: value.message);
      }
    }
  }

  Future addDog() async {
    validateBehaviorsCount();
    validateImage();

    if (_formKey.currentState!.validate() && _minBehaviorCountSelected && _imageAdded) {
      setState(() {
        _isLoading = true;
      });

      final result = await imageService.uploadImage(image!);

      final value = switch (result) {
        Success(value: final photoName) => photoName,
        Failure(error: final error) => error
      };

      if (value is String) {
        String photoName = value;

        List<int> behaviorsIds = _selectedBehaviors.map((item) => item.id)
            .toList();
        final request = DogAdditionRequest(
            photoName,
            _nameController.text.capitalize(),
            _selectedBreed!.id,
            _ageController.text,
            _selectedGender,
            behaviorsIds,
            _descriptionController.text);

        final additionResult = await dogService.addDog(request);

        final additionValue = switch (additionResult) {
          Success(value: final successCode) => successCode,
          Failure(error: final error) => error
        };

        if (context.mounted) {
          if (additionValue is! ApiError) {
            userDogsProvider.fetchUserDogs(context);
            context.router.pop();
          } else {
            showErrorDialog(context: context, message: additionValue.message);
          }
        }

      } else {
        final error = value as ApiError;

        if (context.mounted) {
          showErrorDialog(context: context, message: error.message);
        }
      }

      if (context.mounted) {

      }
    }
  }

  Future updateDog() async {
    validateBehaviorsCount();
    isImageUpdated();

    if (_formKey.currentState!.validate() && _minBehaviorCountSelected) {
      setLoading(true);

      String fileName = widget.dog!.photoUrl.split('/').last;

      if (_imageUpdated) {
        final deletionResult = await imageService.deleteImage(fileName);

        final deletionValue = switch (deletionResult) {
          Success(value: final successCode) => successCode,
          Failure(error: final error) => error
        };

        if (deletionValue is! ApiError) {
          final uploadResult = await imageService.uploadImage(image!);
          final uploadValue = switch (uploadResult) {
            Success(value: final photoName) => photoName,
            Failure(error: final error) => error
          };

          if (uploadValue is String) {
            fileName = uploadValue;
          } else {
            final error = uploadValue as ApiError;
            if (context.mounted) {
              showErrorDialog(context: context, message: error.message);
            }
            return;
          }
        } else {
          if (context.mounted) {
            showErrorDialog(context: context, message: deletionValue.message);
          }
          return;
        }
      }

      List<int> behaviorsIds = _selectedBehaviors.map((item) => item.id)
                .toList();
      final request = DogUpdateRequest(
          widget.dog!.id,
          fileName,
          _nameController.text.capitalize(),
          _selectedBreed!.id,
          _ageController.text,
          _selectedGender,
          behaviorsIds,
          _descriptionController.text);

      final updateResult = await dogService.updateDog(request);

      final updateValue = switch (updateResult) {
        Success(value: final successCode) => successCode,
        Failure(error: final error) => error
      };

      if (context.mounted) {
        if (updateValue is! ApiError) {
          userDogsProvider.fetchUserDogs(context);
          widget.onComplete();
          context.router.pop();
        } else {
          setLoading(false);
          showErrorDialog(context: context, message: updateValue.message);
        }
      }
    }
  }

  void validateBehaviorsCount() {
    setState(() {
      _minBehaviorCountSelected = _selectedBehaviors.length >= _behaviorsMinCount;
    });
  }

  void validateImage() {
    setState(() {
      _imageAdded = image != null;
    });
  }

  void isImageUpdated() {
    setState(() {
      _imageUpdated = image != null;
    });
  }

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }
}


