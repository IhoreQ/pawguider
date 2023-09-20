import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/behavior.dart';
import 'package:front_flutter/repositories/behavior_repository.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/behavior_box.dart';
import 'package:gap/gap.dart';

import '../../models/dog/dog.dart';

@RoutePage()
class EditDogScreen extends StatelessWidget {
  const EditDogScreen({Key? key, required this.dog}) : super(key: key);

  final Dog dog;

  @override
  Widget build(BuildContext context) {
    Dog dogCopy = Dog.clone(dog);
    List<Behavior> behaviors = BehaviorRepository.getAllBehaviors();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit a dog"),
        titleTextStyle: AppTextStyle.appBarTitleHeading,
        titleSpacing: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Text('Traits and behavior',
              style: AppTextStyle.heading2.copyWith(fontSize: 20.0)),
          const Gap(10.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: behaviors.map((behavior) => BehaviorBox(label: behavior.name)).toList(),
          )
        ]
      ),
    );
  }
}
