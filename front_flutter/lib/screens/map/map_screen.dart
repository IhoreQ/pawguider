import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
            "Map"
        ),
      ),
    );
  }
}
