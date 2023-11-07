import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/providers/places_areas_provider.dart';
import 'package:front_flutter/providers/user_location_provider.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/styles.dart';
import 'package:front_flutter/widgets/sized_loading_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late UserProvider userProvider;
  late UserLocationProvider userLocationProvider;
  late PlacesAreasProvider placesAreasProvider;

  @override
  void initState() {
    super.initState();
    userLocationProvider = context.read<UserLocationProvider>();
    userProvider = context.read<UserProvider>();
    placesAreasProvider = context.read<PlacesAreasProvider>();
    placesAreasProvider.fetchPlacesAreasByCityId(context, userProvider.user!.cityId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<UserLocationProvider, PlacesAreasProvider>(
        builder: (context, userLocationProvider, placesAreasProvider, _) {
          return userLocationProvider.currentPosition != null ? GoogleMap(
            mapType: MapType  .normal,
            initialCameraPosition: CameraPosition(
              target: userLocationProvider.currentPosition!,
              zoom: 19
            ),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);


            },
            // markers: {
            //   Marker(
            //     markerId: const MarkerId("5"),
            //     position: LatLng(50.07643195460102, 19.93824100367522),
            //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            //     flat: true
            //   )
            // },
            polygons: placesAreasProvider.areas != null ? Set.from(placesAreasProvider.areas!.map((area) {
              return Polygon(
                polygonId: PolygonId(area.id.toString()),
                consumeTapEvents: true,
                points: area.points,
                fillColor: AppColor.backgroundOrange2.withOpacity(0.5),
                strokeWidth: 2,
                strokeColor: AppColor.primaryOrange,
                onTap: () {
                  context.router.push(PlaceProfileRoute(placeId: area.id));
                },
              );
            }).toList(),
            ) : {},
          ) :
          const SizedLoadingIndicator(color: AppColor.primaryOrange);
        }
      )
    );
  }
}
