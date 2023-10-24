import 'package:auto_route/auto_route.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/widgets/overlay_inkwell.dart';
import 'package:gap/gap.dart';

import '../models/walk.dart';
import '../routes/router.dart';
import '../styles.dart';

class WalkInfoBox extends StatefulWidget {
  const WalkInfoBox({super.key, required this.walk});

  final Walk walk;

  @override
  State<WalkInfoBox> createState() => _WalkInfoBoxState();
}

class _WalkInfoBoxState extends State<WalkInfoBox> {
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
                      widget.walk.place.photoUrl,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  )),
              OverlayInkwell(onTap: () => context.router.push(PlaceProfileRoute(placeId: widget.walk.place.id))),
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
                        widget.walk.place.name,
                        style: AppTextStyle.heading2,
                      ),
                      Text(
                        '${widget.walk.place.street} ${widget.walk.place.houseNumber ?? ''}',
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
                              child: const Icon(
                                FluentSystemIcons.ic_fluent_clock_regular,
                                color: AppColor.primaryOrange,
                              )
                          ),
                          const Gap(3.0),
                          Text(
                              'Started at: ${widget.walk.startTime}',
                              style: AppTextStyle.regularOrange.copyWith(fontSize: 14.0)
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            OverlayInkwell(onTap: () => context.router.push(PlaceProfileRoute(placeId: widget.walk.place.id))),
          ])
        ],
      ),
    ]);
  }
}
