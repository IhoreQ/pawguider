import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/dog.dart';
import 'package:front_flutter/styles.dart';
import 'package:gap/gap.dart';

import '../routes/router.dart';

class DogInfoBox extends StatelessWidget {
  const DogInfoBox({Key? key, required this.dog}) : super(key: key);

  final Dog dog;

  Icon getGenderIcon(bool gender) {
    return Icon(gender ? Icons.male : Icons.female,
        size: 20.0, color: AppColor.primaryOrange);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double widthPadding = 30.0;
    double imageSize = 120.0;
    double descriptionBoxHeight = 100.0;

    return Stack(children: [
      // Row for shadow
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [AppShadow.infoBoxShadow]),
          ),
          Container(
            height: descriptionBoxHeight,
            width: deviceWidth - imageSize - 2 * widthPadding,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(20.0)),
                boxShadow: [
                  AppShadow.infoBoxShadow,
                ]),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      dog.photoUrl,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  )),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => context.router.push(DogProfileRoute(dog: dog, dogId: dog.id)),
                  ),
                ),
              )
            ],
          ),
          Stack(children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: descriptionBoxHeight,
              width: deviceWidth - imageSize - 2 * widthPadding,
              decoration: const BoxDecoration(
                color: AppColor.orangeAccent,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dog.name,
                        style: AppTextStyle.heading2,
                      ),
                      Text(
                        dog.breed,
                        style: AppTextStyle.heading3,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColor.backgroundOrange2,
                                  borderRadius: BorderRadius.circular(50.0)),
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: getGenderIcon(dog.gender)),
                          const Gap(3.0),
                          Text(
                            'Gender',
                            style: AppTextStyle.regularOrange.copyWith(fontSize: 14.0)
                          )
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
                            child: Text("${dog.age}",
                                style: AppTextStyle.mediumOrange.copyWith(fontSize: 14.0)
                            )
                          ),
                          const Gap(3.0),
                          Text(
                            "Age",
                            style: AppTextStyle.regularOrange.copyWith(fontSize: 14.0)
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(20.0)),
                  onTap: () => context.router.push(DogProfileRoute(dog: dog, dogId: dog.id)),
                ),
              ),
            )
          ])
        ],
      ),
    ]);
  }
}
