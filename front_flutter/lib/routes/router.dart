import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/routes/guard/auth_guard.dart';
import 'package:front_flutter/routes/router_pages/home_router_page.dart';
import 'package:front_flutter/routes/router_pages/user_profile_router_page.dart';
import 'package:front_flutter/routes/router_pages/dogs_router_page.dart';
import 'package:front_flutter/routes/router_pages/map_router_page.dart';
import 'package:front_flutter/routes/router_pages/places_router_page.dart';
import 'package:front_flutter/screens/bottom_bar.dart';
import 'package:front_flutter/screens/dog/dog_profile_screen.dart';
import 'package:front_flutter/screens/user/user_profile_screen.dart';
import 'package:front_flutter/screens/map/map_screen.dart';
import 'package:front_flutter/screens/place/places_screen.dart';
import 'package:front_flutter/screens/dog/dogs_screen.dart';
import '../models/dog/dog.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/authentication/register_details_screen.dart';
import '../screens/authentication/register_screen.dart';
import '../screens/dog/dog_details_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/place/place_profile_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [

    CustomRoute(path: '/login', page: LoginRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(path: '/register', page: RegisterRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(path: '/register-details', page: RegisterDetailsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    AutoRoute(path: '/dashboard', page: BottomBarRoute.page, initial: true, children: [
          AutoRoute(path: 'home', page: HomeRouter.page, children: [
            AutoRoute(path: '', page: HomeRoute.page),
            CustomRoute(path: 'place/:placeId', page: PlaceProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'dog/:dogId', page: DogProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'dog/edit', page: DogDetailsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition)
          ]),
          AutoRoute(path: 'dogs', page: DogsRouter.page, children: [
            AutoRoute(path: '', page: DogsRoute.page),
            CustomRoute(path: 'add', page: DogDetailsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: ':dogId', page: DogProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'edit', page: DogDetailsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
          ]),
          AutoRoute(path: 'map', page: MapRouter.page, children: [
            AutoRoute(path: '', page: MapRoute.page),
          ]),
          AutoRoute(path: 'places', page: PlacesRouter.page, children: [
            AutoRoute(path: '', page: PlacesRoute.page),
            CustomRoute(path: ':placeId', page: PlaceProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'dog/:dogId', page: DogProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'dog/edit', page: DogDetailsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition)
          ]),
          AutoRoute(path: 'profile', page: UserProfileRouter.page, children: [
            AutoRoute(path: '', page: UserProfileRoute.page),
          ])
        ]),
      ];
}
