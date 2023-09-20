import 'package:flutter/material.dart';
import 'package:front_flutter/providers/dog_addition_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:front_flutter/routes/router.dart';
import 'models/dog/dog.dart';
import 'styles.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final appRouter = AppRouter();

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
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.primaryOrange,
            selectionColor: AppColor.backgroundOrange2,
            selectionHandleColor: AppColor.primaryOrange
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryOrange),
        ),
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}