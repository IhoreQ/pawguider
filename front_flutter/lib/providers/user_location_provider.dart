import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:front_flutter/providers/active_walk_provider.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/services/user_service.dart';
import 'package:front_flutter/services/walk_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationProvider extends ChangeNotifier {
  LatLng? _currentPosition;
  int _updatesCount = 0;
  final _updatesLimit = 10;
  final UserService userService = UserService();
  final PlaceService placeService = PlaceService();
  final WalkService walkService = WalkService();
  final AuthService authService = AuthService();
  final StreamController<LatLng> _locationController = StreamController<LatLng>.broadcast();
  StreamSubscription<Position>? _positionStreamSubscription;

  Stream<LatLng> get locationStream => _locationController.stream;

  LatLng? get currentPosition => _currentPosition;

  Future<void> fetchUserPosition() async {
    bool serviceEnabled = await isAllowed();

    if (!serviceEnabled) {
      return Future.error('Localisation is not allowed!');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentPosition = LatLng(position.latitude, position.longitude);
    _locationController.add(_currentPosition!);
  }

  Future<void> startListeningLocationUpdates(ActiveWalkProvider walkProvider) async {
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      forceLocationManager: true,
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText:
        "PawGuider is monitoring your location to let other users know if you're on a walk.",
        notificationTitle: "Running in Background",
        enableWakeLock: true,
      )
    );

    bool serviceEnabled = await isAllowed();
    bool isAuthenticated = await authService.isAuthenticated();

    if (!isAuthenticated) {
      return Future.error('User is not authenticated');
    }

    if (!serviceEnabled) {
      return Future.error('Localisation is not allowed!');
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);
      _locationController.add(newPosition);
      _currentPosition = newPosition;
      _updatesCount++;
      if (_updatesCount == _updatesLimit) {
        _updatesCount = 0;
        _handlePositionUpdate(newPosition, walkProvider);
      }
    });
  }

  Future<void> _handlePositionUpdate(LatLng newPosition, ActiveWalkProvider walkProvider) async {
    userService.updatePosition(newPosition);

    if (walkProvider.walk != null) {
      if (!await placeService.isUserInPlaceArea(walkProvider.walk!.place.id, newPosition)) {
        walkService.deleteWalk();
        walkProvider.deleteWalk();
      }
    } else {
      int? placeId = await placeService.findUserPlaceArea(newPosition);

      if (placeId != null) {
        bool added = await walkService.addWalk(placeId);
        if (added) {
          walkProvider.fetchActiveWalk();
        }
      }
    }
  }

  Future<bool> isAllowed() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void stopListeningLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  @override
  void dispose() {
    _locationController.close();
    super.dispose();
  }
}