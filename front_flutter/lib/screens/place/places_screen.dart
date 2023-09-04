import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

@RoutePage()
class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
            "Places"
        ),
      ),
    );
  }
}
