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
import '../../repositories/behavior_repository.dart';

@RoutePage()
class DogAdditionScreen extends StatefulWidget {
  const DogAdditionScreen({super.key});

  @override
  State<DogAdditionScreen> createState() => _DogAdditionScreenState();
}

class _DogAdditionScreenState extends State<DogAdditionScreen> {

  final _picker = ImagePicker();
  File? image;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> breeds = <String>['Mongrel', 'Jack Russel Terrier', 'Yorkshire Terrier'];
  final List<String> genders = <String>['Male', 'Female'];
  List<Behavior> behaviors = BehaviorRepository.getAllBehaviors();

  late String selectedBreed = breeds.first;
  late String selectedGender = genders.first;
  List<Behavior> selectedBehaviors = [];

  final _formKey = GlobalKey<FormState>();

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
        title: const Text("Add a dog"),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO wysyłka na API
                  print(_nameController.text.capitalize());
                  print(_ageController.text);
                  print(selectedBreed);
                  print(selectedGender);
                  print(_descriptionController.text);
                  // context.router.pop();
                }
              },
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
                  child: image == null ?
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
                                    child: Image.file(
                                        File(image!.path).absolute,
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
                    return Validator.isNamevalid(value) ? null : 'Enter correct name';
                  },
                ),
                DropdownButtonFormField(
                    value: selectedBreed,
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
                        selectedBreed = value!;
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
                    dropdownValue: selectedGender,
                    valuesList: genders,
                    labelText: 'Gender',
                  onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
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
                const Gap(10.0),
                Wrap(
                  spacing: 5.0,
                  runSpacing: 10.0 ,
                  children: behaviors.map((behavior) {
                    final isSelected = selectedBehaviors.contains(behavior);
                    return SelectableBehaviorBox(
                        label: behavior.name,
                      onSelected: (isSelected) {
                          isSelected ? selectedBehaviors.add(behavior) : selectedBehaviors.remove(behavior);
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
                  style: AppTextStyle.mediumLight,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'Write something about your dog...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryOrange,
                      ),
                    ),
                    border: OutlineInputBorder(),
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
}
