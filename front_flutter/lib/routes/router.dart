import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
import 'package:front_flutter/screens/dog/dog_addition_screen.dart';
import '../models/dog/dog.dart';
import '../screens/dog/edit_dog_screen.dart';
import '../screens/home_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: BottomBarRoute.page, children: [
          AutoRoute(path: 'home', page: HomeRouter.page, children: [
            AutoRoute(path: '', page: HomeRoute.page),
          ]),
          AutoRoute(path: 'dogs', page: DogsRouter.page, children: [
            AutoRoute(path: '', page: DogsRoute.page),
            CustomRoute(path: 'add', page: DogAdditionRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: ':dogId', page: DogProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
            CustomRoute(path: 'edit', page: EditDogRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
          ]),
          AutoRoute(path: 'map', page: MapRouter.page, children: [
            AutoRoute(path: '', page: MapRoute.page),
          ]),
          AutoRoute(path: 'places', page: PlacesRouter.page, children: [
            AutoRoute(path: '', page: PlacesRoute.page),
          ]),
          AutoRoute(path: 'profile', page: UserProfileRouter.page, children: [
            AutoRoute(path: '', page: UserProfileRoute.page),
          ])
        ],),
      ];
}
