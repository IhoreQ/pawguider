import 'package:auto_route/auto_route.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwtToken = preferences.getString('jwtToken');

    if (jwtToken != null) {
      resolver.next(true);
      router.removeLast();
    }
    else {
      router.push(LoginRoute(onResult: (result) {
        if (result == true) {
          resolver.next(true);
          router.removeLast();
        }
      }));
    }
  }
}
