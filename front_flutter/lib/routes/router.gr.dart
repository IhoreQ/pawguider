// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DogsRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DogsRouterPage(),
      );
    },
    HomeRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeRouterPage(),
      );
    },
    MapRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapRouterPage(),
      );
    },
    PlacesRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlacesRouterPage(),
      );
    },
    UserProfileRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfileRouterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    RegisterDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterDetailsScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    BottomBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomBar(),
      );
    },
    DogsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DogsScreen(),
      );
    },
    DogDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DogDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DogDetailsScreen(
          key: args.key,
          dog: args.dog,
          onComplete: args.onComplete,
        ),
      );
    },
    DogProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DogProfileRouteArgs>(
          orElse: () => DogProfileRouteArgs(dogId: pathParams.getInt('dogId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DogProfileScreen(
          key: args.key,
          dogId: args.dogId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapScreen(),
      );
    },
    PlacesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlacesScreen(),
      );
    },
    PlaceProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PlaceProfileRouteArgs>(
          orElse: () =>
              PlaceProfileRouteArgs(placeId: pathParams.getInt('placeId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlaceProfileScreen(
          key: args.key,
          placeId: args.placeId,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfileScreen(),
      );
    },
    EditPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditPasswordScreen(),
      );
    },
    UserEditRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserEditScreen(),
      );
    },
  };
}

/// generated route for
/// [DogsRouterPage]
class DogsRouter extends PageRouteInfo<void> {
  const DogsRouter({List<PageRouteInfo>? children})
      : super(
          DogsRouter.name,
          initialChildren: children,
        );

  static const String name = 'DogsRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeRouterPage]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MapRouterPage]
class MapRouter extends PageRouteInfo<void> {
  const MapRouter({List<PageRouteInfo>? children})
      : super(
          MapRouter.name,
          initialChildren: children,
        );

  static const String name = 'MapRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlacesRouterPage]
class PlacesRouter extends PageRouteInfo<void> {
  const PlacesRouter({List<PageRouteInfo>? children})
      : super(
          PlacesRouter.name,
          initialChildren: children,
        );

  static const String name = 'PlacesRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserProfileRouterPage]
class UserProfileRouter extends PageRouteInfo<void> {
  const UserProfileRouter({List<PageRouteInfo>? children})
      : super(
          UserProfileRouter.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterDetailsScreen]
class RegisterDetailsRoute extends PageRouteInfo<void> {
  const RegisterDetailsRoute({List<PageRouteInfo>? children})
      : super(
          RegisterDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BottomBar]
class BottomBarRoute extends PageRouteInfo<void> {
  const BottomBarRoute({List<PageRouteInfo>? children})
      : super(
          BottomBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomBarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DogsScreen]
class DogsRoute extends PageRouteInfo<void> {
  const DogsRoute({List<PageRouteInfo>? children})
      : super(
          DogsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DogsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DogDetailsScreen]
class DogDetailsRoute extends PageRouteInfo<DogDetailsRouteArgs> {
  DogDetailsRoute({
    Key? key,
    Dog? dog,
    required void Function() onComplete,
    List<PageRouteInfo>? children,
  }) : super(
          DogDetailsRoute.name,
          args: DogDetailsRouteArgs(
            key: key,
            dog: dog,
            onComplete: onComplete,
          ),
          initialChildren: children,
        );

  static const String name = 'DogDetailsRoute';

  static const PageInfo<DogDetailsRouteArgs> page =
      PageInfo<DogDetailsRouteArgs>(name);
}

class DogDetailsRouteArgs {
  const DogDetailsRouteArgs({
    this.key,
    this.dog,
    required this.onComplete,
  });

  final Key? key;

  final Dog? dog;

  final void Function() onComplete;

  @override
  String toString() {
    return 'DogDetailsRouteArgs{key: $key, dog: $dog, onComplete: $onComplete}';
  }
}

/// generated route for
/// [DogProfileScreen]
class DogProfileRoute extends PageRouteInfo<DogProfileRouteArgs> {
  DogProfileRoute({
    Key? key,
    required int dogId,
    List<PageRouteInfo>? children,
  }) : super(
          DogProfileRoute.name,
          args: DogProfileRouteArgs(
            key: key,
            dogId: dogId,
          ),
          rawPathParams: {'dogId': dogId},
          initialChildren: children,
        );

  static const String name = 'DogProfileRoute';

  static const PageInfo<DogProfileRouteArgs> page =
      PageInfo<DogProfileRouteArgs>(name);
}

class DogProfileRouteArgs {
  const DogProfileRouteArgs({
    this.key,
    required this.dogId,
  });

  final Key? key;

  final int dogId;

  @override
  String toString() {
    return 'DogProfileRouteArgs{key: $key, dogId: $dogId}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlacesScreen]
class PlacesRoute extends PageRouteInfo<void> {
  const PlacesRoute({List<PageRouteInfo>? children})
      : super(
          PlacesRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlacesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlaceProfileScreen]
class PlaceProfileRoute extends PageRouteInfo<PlaceProfileRouteArgs> {
  PlaceProfileRoute({
    Key? key,
    required int placeId,
    List<PageRouteInfo>? children,
  }) : super(
          PlaceProfileRoute.name,
          args: PlaceProfileRouteArgs(
            key: key,
            placeId: placeId,
          ),
          rawPathParams: {'placeId': placeId},
          initialChildren: children,
        );

  static const String name = 'PlaceProfileRoute';

  static const PageInfo<PlaceProfileRouteArgs> page =
      PageInfo<PlaceProfileRouteArgs>(name);
}

class PlaceProfileRouteArgs {
  const PlaceProfileRouteArgs({
    this.key,
    required this.placeId,
  });

  final Key? key;

  final int placeId;

  @override
  String toString() {
    return 'PlaceProfileRouteArgs{key: $key, placeId: $placeId}';
  }
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditPasswordScreen]
class EditPasswordRoute extends PageRouteInfo<void> {
  const EditPasswordRoute({List<PageRouteInfo>? children})
      : super(
          EditPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserEditScreen]
class UserEditRoute extends PageRouteInfo<void> {
  const UserEditRoute({List<PageRouteInfo>? children})
      : super(
          UserEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserEditRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
