import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/utilities/validator.dart';
import 'package:front_flutter/widgets/custom_dropdown_button.dart';
import 'package:front_flutter/widgets/custom_form_field.dart';
import 'package:front_flutter/widgets/selectable_behavior_box.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:front_flutter/utilities/extensions.dart';

import '../../models/behavior.dart';
import '../../models/dog/dog.dart';
import '../../repositories/behavior_repository.dart';

// TODO zamień to wszędzie zamiast DogAdditionScreen

@RoutePage()
class DogDetailsScreen extends StatefulWidget {
  const DogDetailsScreen({super.key, this.dog});

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

  final List<String> breeds = <String>['Mongrel', 'Jack Russel Terrier', 'Yorkshire Terrier'];
  final List<String> genders = <String>['Male', 'Female'];
  final List<Behavior> behaviors = BehaviorRepository.getAllBehaviors();

  late String _selectedBreed = breeds.first;
  late String _selectedGender = genders.first;
  List<Behavior> _selectedBehaviors = [];

  int behaviorsMinCount = 3;
  bool minBehaviorCountSelected = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.dog != null) {
      _nameController.text = widget.dog!.name;
      _ageController.text = '${widget.dog!.age}';
      _descriptionController.text = widget.dog!.description;
      _selectedGender = genders.firstWhere((element) {
        String dogGender = widget.dog!.gender ? 'Male' : 'Female';
        return element == dogGender;
      });
      _selectedBreed = breeds.firstWhere((element) => element == widget.dog!.breed);
      _selectedBehaviors = Dog.clone(widget.dog!).behaviors;
    }
  }

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> uploadImage() async {}

  Future _selectPhoto() async {
    await showModalBottomSheet(useRootNavigator: true, context: context, builder: (context) => BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _getImage(ImageSource.camera),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
            child: ListTile(
              leading: const Icon(
                FluentSystemIcons.ic_fluent_camera_filled,
                size: 25.0,
                color: AppColor.lightText,
              ),
              title: Text('Camera', style: AppTextStyle.mediumLight),
            ),
          ),
          ListTile(
            leading: const Icon(
              FluentSystemIcons.ic_fluent_image_filled,
              size: 25.0,
              color: AppColor.lightText,
            ),
            title: Text('Pick a photo', style: AppTextStyle.mediumLight,),
            onTap: () => _getImage(ImageSource.gallery),
          ),
        ],
      ), onClosing: () {},
    ));
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 30.0;

    return Scaffold(
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
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => widget.dog != null ? updateDog() : addDog(),
              icon: const Icon(
                FluentSystemIcons.ic_fluent_checkmark_filled,
                size: iconSize,
                color: Colors.white,
              ))
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
                            onPressed: () => _selectPhoto(),
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
                          onTap: () => _selectPhoto(),
                          child: Text('Add dog picture', style: AppTextStyle.semiBoldLight)
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
                                        onTap: () => _selectPhoto()),
                                  ),
                                ),
                              ]
                          )
                      ),
                      const Gap(10.0),
                      GestureDetector(
                          onTap: () => _selectPhoto(),
                          child: Text('Change picture', style: AppTextStyle.semiBoldOrange)
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
                      RegExp(r"[a-zA-Z]+|\s"),
                    ),
                  ],
                  validator: (value) {
                    return Validator.isDogNameValid(value) ? null : 'Enter correct name';
                  },
                ),
                DropdownButtonFormField(
                    value: _selectedBreed,
                    items: breeds.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
                        _selectedBreed = value!;
                      });
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
                  valuesList: genders,
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
                !minBehaviorCountSelected ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'You have to select at least $behaviorsMinCount traits',
                      style: AppTextStyle.errorText,
                    )
                ) : const SizedBox(),
                const Gap(10.0),
                Wrap(
                  spacing: 5.0,
                  runSpacing: 10.0 ,
                  children: behaviors.map((behavior) {
                    final isBehaviorSelected = _selectedBehaviors.any((selectedBehavior) => selectedBehavior.id == behavior.id);
                    return SelectableBehaviorBox(
                      label: behavior.name,
                      initValue: isBehaviorSelected,
                      onSelected: (isSelected) {
                        if (isSelected) {
                          _selectedBehaviors.add(behavior);
                        } else {
                          _selectedBehaviors.removeWhere((selectedBehavior) => selectedBehavior.id == behavior.id);
                        }
                      },
                    );
                  }).toList(),
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
                  style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0),
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
                const Gap(20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDog() {
    print('add');
    setState(() {
      minBehaviorCountSelected = _selectedBehaviors.length >= behaviorsMinCount;
    });

    if (_formKey.currentState!.validate() && minBehaviorCountSelected) {
      // TODO wysyłka na API
      // TODO capitalize() na name
      // context.router.pop();
    }
  }

  void updateDog() {
    print('update');
  }
}
