import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_flutter/providers/dog_addition_form_provider.dart';
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
      ChangeNotifierProvider(create: (context) =>  DogAdditionFormProvider()),
    ];

    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bottom navbar with nested routing',
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