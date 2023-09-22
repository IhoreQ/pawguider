import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';
import 'package:gap/gap.dart';

import '../models/place.dart';
import '../routes/router.dart';

class PlaceInfoBox extends StatelessWidget {
  const PlaceInfoBox({Key? key, required this.place}) : super(key: key);

  final Place place;

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
                      place.photoUrl,
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
                    onTap: () => context.router.push(PlaceProfileRoute(placeId: place.id)),
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
                        place.name,
                        style: AppTextStyle.heading2,
                      ),
                      Text(
                        place.street,
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
                              child: Text('${place.dogsCount}', style: AppTextStyle.mediumOrange.copyWith(fontSize: 14.0),),
                          ),
                          const Gap(3.0),
                          Text(
                              'Dogs here',
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
                              child: const Icon(
                                FluentSystemIcons.ic_fluent_star_filled,
                                size: 20.0,
                                color: AppColor.primaryOrange,
                              )
                          ),
                          const Gap(3.0),
                          Text(
                              "${place.averageScore}",
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
                  onTap: () => context.router.push(PlaceProfileRoute(placeId: place.id)),
                ),
              ),
            )
          ])
        ],
      ),
    ]);
  }
}
