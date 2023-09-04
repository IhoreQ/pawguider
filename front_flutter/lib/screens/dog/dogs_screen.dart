import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/dog.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/widgets/dog_info_box.dart';
import 'package:gap/gap.dart';

import '../../styles.dart';

@RoutePage()
class DogsScreen extends StatelessWidget {
  DogsScreen({super.key});

  final Dog exampleDog = Dog('12', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG');
  final Dog exampleDog2 = Dog('13', 'Ciapek', 'Jack Russel Terrier', true, 12, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Jack_Russell_Terrier_-_bitch_Demi.JPG/1200px-Jack_Russell_Terrier_-_bitch_Demi.JPG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 25.0
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Your dogs",
              style: AppTextStyle.heading1
            ),
          ),
          const Gap(30.0),
          // Pobranie listy psów z API oraz wyświetlenie
          DogInfoBox(dog: exampleDog),
          const Gap(15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10.0),
              backgroundColor: AppColor.primaryOrange,
            ),
            child: const Icon(
              Icons.add,
              size: 30,
              color: AppColor.orangeAccent,
            ),
            onPressed: () => context.router.push(const AddDogRoute()),
          ),
        ],
      )
    );
  }
}
