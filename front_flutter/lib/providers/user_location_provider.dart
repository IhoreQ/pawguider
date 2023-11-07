import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/providers/active_walk_provider.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/services/user_service.dart';
import 'package:front_flutter/services/walk_service.dart';
import 'package:front_flutter/strings.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';
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

  Future<void> startListeningLocationUpdates(BuildContext context, ActiveWalkProvider walkProvider) async {
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
      if (context.mounted) {
        showErrorDialog(context: context, message: ErrorStrings.notAuthenticated);
      }
      return Future.error(ErrorStrings.notAuthenticated);
    }

    if (!serviceEnabled) {
      if (context.mounted) {
        showErrorDialog(context: context, message: ErrorStrings.localisationNotAllowed);
      }
      return Future.error(ErrorStrings.localisationNotAllowed);
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
        _handlePositionUpdate(context, newPosition, walkProvider);
      }
    });
  }

  Future _handlePositionUpdate(BuildContext context, LatLng newPosition, ActiveWalkProvider walkProvider) async {
    final result = await userService.updatePosition(newPosition);
    final value = switch (result) {
      Success(value: final successCode) => successCode,
      Failure(error: final error) => error
    };

    if (value is ApiError && context.mounted) {
      showErrorDialog(context: context, message: value.message);
      return;
    }

    if (walkProvider.walk != null) {
      final result = await placeService.isUserInPlaceArea(walkProvider.walk!.place.id, newPosition);
      final value = switch (result) {
        Success(value: final inPlaceArea) => inPlaceArea,
        Failure(error: final error) => error
      };

      if (value is bool) {
        final inPlaceArea = value;

        if (!inPlaceArea) {
          final deletionResult = await walkService.deleteWalk();
          final deletionValue = switch (deletionResult) {
            Success(value: final successCode) => successCode,
            Failure(error: final error) => error
          };

          if (deletionValue is! ApiError) {
            walkProvider.deleteWalk();
          } else {
            if (context.mounted) {
              showErrorDialog(context: context, message: deletionValue.message);
            }
          }
        }
      } else {
        final error = value as ApiError;
        if (context.mounted) {
          showErrorDialog(context: context, message: error.message);
        }
      }
    } else {
        final result = await placeService.findUserPlaceArea(newPosition);
        final value = switch (result) {
          Success(value: final placeId) => placeId,
          Failure(error: final error) => error
        };

        if (value is! ApiError) {
          int? placeId = value as int?;

          if (placeId != null) {
            final additionResult = await walkService.addWalk(placeId);
            final additionValue = switch (additionResult) {
              Success(value: final successCode) => successCode,
              Failure(error: final error) => error
            };
            if (context.mounted) {
              if (additionValue is! ApiError) {
                walkProvider.fetchActiveWalk(context);
              } else {
                if (additionValue.message != ErrorStrings.checkInternetConnection) {
                  showErrorDialog(context: context, message: additionValue.message);
                }
              }
            }
          }
        } else {
          if (context.mounted) {
            showErrorDialog(context: context, message: value.message);
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