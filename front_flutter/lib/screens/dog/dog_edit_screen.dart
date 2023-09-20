import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/behavior.dart';
import 'package:front_flutter/repositories/behavior_repository.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/selectable_behavior_box.dart';
import 'package:gap/gap.dart';

import '../../models/dog/dog.dart';

@RoutePage()
class DogEditScreen extends StatefulWidget {
  const DogEditScreen({Key? key, required this.dog}) : super(key: key);

  final Dog dog;

  // TODO przerobić ten screen tak, że gdy zostanie podany parametr dog to wtedy wyświetla się ekran edycji, a jak nie to dodawania - podzielić na widgety

  @override
  State<DogEditScreen> createState() => _DogEditScreenState();
}

class _DogEditScreenState extends State<DogEditScreen> {
  final List<Behavior> behaviors = BehaviorRepository.getAllBehaviors();

  @override
  Widget build(BuildContext context) {

    const double iconSize = 30.0;
    Dog dogCopy = Dog.clone(widget.dog);
    List<Behavior> selectedBehaviors = dogCopy.behaviors;
    List<Behavior> behaviors = BehaviorRepository.getAllBehaviors();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit a dog"),
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
              onPressed: () => onSubmit(),
              icon: const Icon(
                FluentSystemIcons.ic_fluent_checkmark_filled,
                size: iconSize,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Text('Traits and behavior',
              style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
          const Gap(10.0),
          Wrap(
            spacing: 5.0,
            runSpacing: 10.0,
            children: behaviors.map((behavior) {
              final isBehaviorSelected = selectedBehaviors.any((selectedBehavior) => selectedBehavior.id == behavior.id);
              return SelectableBehaviorBox(
                label: behavior.name,
                initValue: isBehaviorSelected,
                onSelected: (isSelected) {
                  if (isSelected) {
                    selectedBehaviors.add(behavior);
                  } else {
                    selectedBehaviors.removeWhere((selectedBehavior) => selectedBehavior.id == behavior.id);
                  }
                },
              );
            }).toList(),
          )
        ]
      ),
    );
  }

  void onSubmit() {

  }
}
