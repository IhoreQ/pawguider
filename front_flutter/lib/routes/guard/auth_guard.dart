import 'package:auto_route/auto_route.dart';
import 'package:front_flutter/routes/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    router.push(LoginRoute(
      onResult: (result) {
        if (result == true) {
          resolver.next(true);
          router.removeLast();
        }
      }
    ));
  }
}