import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/styles.dart';

@RoutePage()
class AddDogScreen extends StatelessWidget {
  const AddDogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a dog"),
        titleTextStyle: AppTextStyle.appBarTitleHeading,
        titleSpacing: 0.0,
      ),
      body: Column(
        children: [
          Text("Hej"),
        ],
      ),
    );
  }
}
