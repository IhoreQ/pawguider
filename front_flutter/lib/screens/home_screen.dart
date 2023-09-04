import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
          "Home"
        ),
      ),
    );
  }
}
