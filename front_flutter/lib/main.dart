import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/providers/favourite_places_provider.dart';
import 'package:front_flutter/providers/loading_provider.dart';
import 'package:front_flutter/providers/register_details_provider.dart';
import 'package:front_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'styles.dart';

void main() {
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryOrange, // Kolor paska statusu
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {

    final providers = [
      ChangeNotifierProvider(create: (context) =>  UserProvider()),
      ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ChangeNotifierProvider(create: (context) => RegisterDetailsProvider()),
      ChangeNotifierProvider(create: (context) => FavouritePlacesProvider()),
    ];

    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'PawGuider',
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColor.primaryOrange,
            selectionColor: AppColor.backgroundOrange2,
            selectionHandleColor: AppColor.primaryOrange
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryOrange),
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(includePrefixMatches: true),
      ),
    );
  }
}