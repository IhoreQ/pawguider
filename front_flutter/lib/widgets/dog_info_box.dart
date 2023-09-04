import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/dog.dart';
import 'package:gap/gap.dart';

import '../routes/router.dart';
import '../styles.dart';

class DogInfoBox extends StatelessWidget {
  const DogInfoBox({Key? key, required this.dog}) : super(key: key);

  final Dog dog;

  Icon getGenderIcon(bool gender) {
    return Icon(
      gender ? Icons.male : Icons.female,
      size: 20.0,
      color: AppColor.primaryOrange);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: AppColor.backgroundOrange
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onTap: () => context.router.push(SingleDogRoute(dogId: dog.id)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: NetworkImage(dog.photoUrl),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dog.name, style: AppTextStyle.heading2,),
                          Text(dog.breed, style: AppTextStyle.heading3,),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.backgroundOrange2,
                                    borderRadius: BorderRadius.circular(50.0)
                                ),
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: getGenderIcon(dog.gender)
                              ),
                              const Gap(3.0),
                              const Text('Gender', style: TextStyle(color: AppColor.primaryOrange, fontSize: 17),)
                            ],
                          ),
                          const Gap(10.0),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.backgroundOrange2,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text("${dog.age}", style: const TextStyle(color: AppColor.primaryOrange, fontSize: 17)),
                              ),
                              const Gap(3.0),
                              const Text("Age", style: TextStyle(color: AppColor.primaryOrange, fontSize: 17),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
