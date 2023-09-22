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
    BottomBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomBar(),
      );
    },
    DogsRoute.name: (routeData) {
      final args =
          routeData.argsAs<DogsRouteArgs>(orElse: () => const DogsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DogsScreen(key: args.key),
      );
    },
    DogProfileRoute.name: (routeData) {
      final args = routeData.argsAs<DogProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DogProfileScreen(
          key: args.key,
          dog: args.dog,
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
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserProfileScreen(),
      );
    },
    DogDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DogDetailsRouteArgs>(
          orElse: () => const DogDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DogDetailsScreen(
          key: args.key,
          dog: args.dog,
        ),
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
class DogsRoute extends PageRouteInfo<DogsRouteArgs> {
  DogsRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DogsRoute.name,
          args: DogsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DogsRoute';

  static const PageInfo<DogsRouteArgs> page = PageInfo<DogsRouteArgs>(name);
}

class DogsRouteArgs {
  const DogsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'DogsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [DogProfileScreen]
class DogProfileRoute extends PageRouteInfo<DogProfileRouteArgs> {
  DogProfileRoute({
    Key? key,
    required Dog dog,
    required String dogId,
    List<PageRouteInfo>? children,
  }) : super(
          DogProfileRoute.name,
          args: DogProfileRouteArgs(
            key: key,
            dog: dog,
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
    required this.dog,
    required this.dogId,
  });

  final Key? key;

  final Dog dog;

  final String dogId;

  @override
  String toString() {
    return 'DogProfileRouteArgs{key: $key, dog: $dog, dogId: $dogId}';
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
/// [DogDetailsScreen]
class DogDetailsRoute extends PageRouteInfo<DogDetailsRouteArgs> {
  DogDetailsRoute({
    Key? key,
    Dog? dog,
    List<PageRouteInfo>? children,
  }) : super(
          DogDetailsRoute.name,
          args: DogDetailsRouteArgs(
            key: key,
            dog: dog,
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
  });

  final Key? key;

  final Dog? dog;

  @override
  String toString() {
    return 'DogDetailsRouteArgs{key: $key, dog: $dog}';
  }
}
