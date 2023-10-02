import 'package:auto_route/auto_route.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'package:front_flutter/services/auth_service.dart';

class AuthGuard extends AutoRouteGuard {

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authService = AuthService();

    if (await authService.isAuthenticated()) {
      resolver.next(true);
      router.removeLast();
    }
    else {
      router.push(const LoginRoute());
    }
  }
}
