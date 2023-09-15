import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'models/dog.dart';
import 'styles.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bottom navbar with nested routing',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryOrange),
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}