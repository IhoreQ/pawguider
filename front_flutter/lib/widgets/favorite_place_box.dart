import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/models/place.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/overlay_inkwell.dart';
import 'package:gap/gap.dart';

import '../routes/router.dart';

class FavoritePlaceBox extends StatelessWidget {
  const FavoritePlaceBox({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 180.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: [
          Image.network(
            place.photoUrl,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: BlurryContainer(
              width: imageSize,
              height: 50.0,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(10.0),
              blur: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(place.name, style: AppTextStyle.semiBoldWhite,),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white, size: 16.0,),
                        Text('${place.city}, ${place.street}', style: AppTextStyle.regularWhite.copyWith(fontSize: 11.0),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          OverlayInkwell(onTap: () => context.router.push(PlaceProfileRoute(placeId: place.id)))
        ],
      ),
    );
  }
}